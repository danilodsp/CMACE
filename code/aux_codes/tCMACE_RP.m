%% Total clean
clear; clc; close all;

tic
%% Training
rs = 3;     % Number of random samples used for training
cs = 10;    % Training class total size
nc = 03;    % Number of different training classes
iM = 112;   % Training image size M x N, is necessary to
iN = 92;    %   adjust for each training set
s = .1;     % Standard deviation - filter size
d = iM*iN;  % length(x)
N = nc*rs;  % Number of total training samples
k = 25*25;  % New images dimension - Random Projection Method

% P = 2 * ( round( rand(k,d) ) -.5 ) / sqrt(k);
P = randn(k,d) / sqrt(k);

x = zeros(k,N);
c = zeros(N,1);
for cn=1:nc,
    aux = randperm(cs);
    for sn=1:rs,
        Itmp = double(imread(['att_faces/s',num2str(cn),'/',num2str(aux(sn)),'.pgm']));
        x(:,(cn-1)*rs + sn) = P * Itmp(:);
    end
    c((1:rs)+rs*(cn-1),1) = cn;
end

clear aux Itmp;

toc
%% Filter design - 1
x1 = [ x ; zeros(k-1,N) ];

ks = @(x,y,s)( exp( -(x - y).^2 / (2*s^2) ) );

vi = zeros(k,nc*rs);
for i=1:nc*rs,
    for l=0:(k-1),
        vi(:,i) = sum( ks( x(:,i) , x1( (1+l):(k+l) , i ) , s )  );
    end
end

clear x1;

vx = sum(vi,2) / ( N * ( sqrt(2*pi)*s ) );

clear vi;

Vx = zeros(k,k);
Vx(:,1) = vx;
for ni=2:k,
    Vx(:,ni) = [ vx(ni:-1:1) ; vx(2:(k-ni+1)) ];
end

W = Vx\eye(size(Vx));   % inv(Vx);

clear Vx;

toc
%% Filter design - 2
Txx = zeros(N,N);
for i=1:N,
    for j=1:N,
        for l=1:k,
            for kk=1:k,
                Txx(i,j) = Txx(i,j) + W(l,kk) * ks( x(kk,i) , x(l,j) , s );
            end
        end
    end
end

Txx = Txx / ( sqrt(2*pi)*s );

toc
%% Test images
L = 10;     % Number of testing images, L <= cs (not greater than)
tc = 27;    % Testing class number

z = zeros(k,L);
for ts=1:L,
    aux = randperm(cs);
    Itmp = double(imread(['att_faces/s',num2str(tc),'/',num2str(aux(ts)),'.pgm']));
    z(:,ts) = P * Itmp(:);
end

clear Itmp;

toc
%% Filter response - 1
Tzx = zeros(L,N);
for i=1:L,
    for j=1:N,
        for l=1:k,
            for kk=1:k,
                Tzx(i,j) = Tzx(i,j) + W(l,kk) * ks( z(kk,i) , x(l,j) , s );
            end
        end
    end
end

Tzx = Tzx / ( sqrt(2*pi)*s );

toc
%% Filter response - 2
y = Tzx / Txx * c;

toc
beep

%% Checkpoint
save('cmace_var01','x','z','Txx','Tzx','s','nc','rs','P');