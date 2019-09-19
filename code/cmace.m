%% Antigo
clear; clc; close all;

Itmp = [];
x = [];

for j=1:40
    for i=1:3
        Itmp = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        Itmp = im2double(Itmp);
        x = [x Itmp(:)];
    end
end

[M N qtd] = size(Itmp);

ks = @(x,y,s)( exp( -(x - y).^2 / (2*s^2) ) );

%% Training
rs = 3;     % Number of random samples used for training
cs = 10;    % Training class total size
nc = 04;    % Number of different training classes
iM = 112;   % Training image size M x N, is necessary to
iN = 92;    %   adjust for each training set
s = .1;     % Standard deviation - filter size
d = iM*iN;  % length(x)
N = nc*rs;  % Number of total training samples

x = zeros(d,N);
c = zeros(N,1);
for cn=1:nc,
    aux = randperm(cs);
    for sn=1:rs,
        Itmp = imread(['s',num2str(cn),'/',num2str(aux(sn)),'.pgm']);
        x(:,(cn-1)*rs + sn) = Itmp(:);
    end
    c((1:rs)+rs*(cn-1),1) = cn;
end
x = double(x);

clear aux Itmp;
%% Filter design - 1
x1 = [ x ; zeros(d-1,N) ];

ks = @(x,y,s)( exp( -(x - y).^2 / (2*s^2) ) );

vi = zeros(d,nc*rs);
for i=1:nc*rs,
    for l=0:(d-1),
        vi(:,i) = sum( ks( x(:,i) , x1( (1+l):(d+l) , i ) , s )  );
    end
end

clear x1;

vx = sum(vi,2) / ( N * ( sqrt(2*pi)*s ) );

clear vi;

Vx = zeros(d,d);
Vx(:,1) = vx;
for ni=2:d,
    Vx(:,ni) = [ vx(ni:-1:1) ; vx(2:(d-ni+1)) ];
end

W = Vx\eye(size(Vx));   % inv(Vx);

clear Vx;
%% Filter design - 2
Txx = zeros(N,N);
for i=1:N,
    for j=1:N,
        for l=1:d,
            for k=1:d,
                Txx(i,j) = Txx(i,j) + W(l,k) * ks( x(i,k) , x(j,l) , s );
            end
        end
    end
end

Txx = Txx / ( sqrt(2*pi)*s );
%% Test images
L = 10;     % Number of testing images, L <= cs (not greater than)
tc = 27;    % Testing class number

z = zeros(d,L);
for ts=1:L,
    aux = randperm(cs);
    Itmp = imread(['s',num2str(tc),'/',num2str(aux(ts)),'.pgm']);
    z(:,ts) = Itmp(:);
end
z = double(z);

clear Itmp;
%% Filter response - 1
Tzx = zeros(L,N);
for i=1:L,
    for j=1:N,
        for l=1:d,
            for k=1:d,
                Txx(i,j) = Txx(i,j) + W(l,k) * ks( z(i,k) , x(j,l) , s );
            end
        end
    end
end

Tzx = Tzx / ( sqrt(2*pi)*s );
%% Filter response - 2
y = Tzx / Txx * c;

%save('cmace_var','x','z','Txx','Tzx','s','nc','rs');