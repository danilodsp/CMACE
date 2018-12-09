% Federal University of Rio Grande do Norte
% Title: MACE filter
% Author: Danilo Pena
% Description: Minimum Average Correlation Energy (MACE)

clear
close all
clc

I = [];
X = [];

% Training
for j=1:40
    for i=1:3
        Itmp = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        Itmp = im2double(Itmp);
        Itmp = fft2(Itmp);
        X = [X Itmp(:)];
    end
end
[M N qtd] = size(Itmp);

% Vector u, with the selection of the training set
u = zeros(120,1);
u(4:6) = 1;
%u(7:9) = 2;
%u(10:12) = 3;

% Creating the filter
D = diag(mean(abs(X),2));
%D = eye(length(X));
XDX = ctranspose(X) * (D \ X);
h = (D \ X) * (XDX \ u);
H = reshape(h, size(Itmp)); % Filter

%% Tests
test = imread('s4/4.pgm'); % Images checked
test = im2double(test);
test = fft2(test);

result = ifftshift(ifft2(test .* conj(H)));
mesh(real(result * (M*N)))

%G = filter2(H,test);
%g = ifftshift(ifft2(ifftshift(G)));
%mesh(real(g))