%% Total clean
clear; clc; close all;

tic
%% Training
rs = 3;     % Number of random samples used for training
cs = 10;    % Training class total size
nc = 40;    % Number of different training classes
iM = 112;   % Training image size M x N, is necessary to
iN = 92;    %   adjust for each training set
s = .1;     % Standard deviation - filter size
d = iM*iN;  % length(x)
N = nc*rs;  % Number of total training samples

X = zeros(d,N);
u = zeros(N,1);
aux = [1 2 3];
for cn=1:nc,
%     aux = randperm(cs);
    for sn=1:rs,
        Itmp = imread(['s',num2str(cn),'/',num2str(aux(sn)),'.pgm']);
        Itmp = fft2(im2double(Itmp));
        X(:,(cn-1)*rs + sn) = Itmp(:);
    end
    u((1:rs)+rs*(cn-1),1) = cn==2;
end

toc
%% Filter design
D = diag(mean(abs(X).^2,2));

h = (D \ X) * ( ( (X') * (D \ X) ) \ u);

H = reshape(h, size(Itmp));

toc

%% Testing images - Output plane
ts = 06;    % Testing sample
tc = 27;    % Testing class number

aux = randperm(ts);
teste = imread(['s',num2str(tc),'/',num2str(aux(ts)),'.pgm']);
teste = fft2(im2double(teste));

outPlan = real( ifftshift( ifft2( teste .* conj(H) ) ) ) * d;

mesh(outPlan,ones(size(outPlan)));
axis([1 iN 1 iM 0 1]);
title(['Classe ' num2str(tc) ' - imagem ' num2str(ts)...
       ' - pico ' num2str(max(max(outPlan)))]);

toc
% sEPS('teste');
beep

%% Testing images - Visualization
% L = 10;     % Number of testing images, L <= cs (not greater than)
% tc = 27;    % Testing class number
% 
% for ts=1:L,
%     aux = randperm(ts);
%     teste = imread(['att_faces/s',num2str(tc),'/',num2str(aux(ts)),'.pgm']);
%     teste = fft2(im2double(teste));
%     
%     outPlan = real( ifftshift( ifft2( teste .* conj(H) ) ) ) * d;
%     mesh(outPlan);
%     axis([1 iN 1 iM 0 1]);
%     title(['Classe ' num2str(tc) ' - imagem ' num2str(ts)...
%            ' - pico ' num2str(max(max(outPlan)))]);
%     drawnow;
%     pause;
% end
% 
% toc
% beep

%% Test images - Peak matrix
% L = cs;     % Number of testing images, L <= cs (not greater than)
% 
% aux = 1:L;
% pM = zeros(L,nc);
% for tc=1:nc,
%     for ts=1:L,
% %         aux = randperm(ts);
%         teste = imread(['att_faces/s',num2str(tc),'/',num2str(aux(ts)),'.pgm']);
%         teste = fft2(im2double(teste));
%         
%         outPlan = real( ifftshift( ifft2( teste .* conj(H) ) ) ) * d;
%         
%         pM(ts,tc) = max(max(outPlan));
%     end
% end
% 
% plot(pM(:));
% grid on;
% title('Picos dos planos de saida');
% 
% toc
% beep