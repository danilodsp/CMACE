%% Total clean
clear; clc; close all;

%% Training
rs = 3;     % Number of random samples used for training
cs = 10;    % Training class total size
nc = 40;    % Number of different training classes
M = 112;    % Training image size M x N, is necessary to
N = 92;     %   adjust for each training set

x = zeros(M*N,nc*rs);
for cn=1:nc,
    aux = randperm(cs);
    for sn=1:rs,
        Itmp = imread(['s',num2str(cn),'/',num2str(aux(sn)),'.pgm']);
        x(:,(cn-1)*rs + sn) = Itmp(:);
    end
end

%% Filter design
x = double(x);

U = zeros(M*N,nc*rs);
U((M*N)/2,:) = 255;
h = x / (x' * x) * U';
H = sum(h,2);

%% Testing
tc = 14;    % Testing class number

test = zeros(M*N,cs);
for ts=1:cs,
    Itmp = imread(['s',num2str(tc),'/',num2str(aux(ts)),'.pgm']);
    test(:,ts) = Itmp(:);
end
test = double(test);

result = H' * test;