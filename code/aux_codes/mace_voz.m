%clear
I = [];
X = [];

% Treinamento
% for j=1:40
%     for i=1:3
%         Itmp = imread(['s',num2str(j),'/',num2str(i),'.pgm']); % Imagens temporárias
%         Itmp = im2double(Itmp);
%         Itmp = fft2(Itmp);
%         X = [X Itmp(:)];
%     end
% end
% [M N qtd] = size(Itmp);
XEdema = [];
XNormals = [];

for j=1:20
    XEdema(j,:) = fft(vetorEdema(j,:));
end
for j=1:20
    XNormals(j,:) = fft(vetorNormals(j,:));
end

X = [];
X = [XEdema' XNormals'];

% Vetor u, com a seleção do conjunto de treinamento
u = zeros(40,1);
u(1:1) = 1;

% Construção do filtro
D = diag(mean(abs(X),2));
%D = eye(length(X));
XDX = ctranspose(X) * (D \ X);
h = (D \ X) * (XDX \ u);
H = reshape(h, [1 1001]); % Filtro

% % Testes
% test = imread('s2/1.pgm'); % Imagem a ser testada
% test = im2double(test);
% test = fft2(test);
% 
% result = ifftshift(ifft2(test .* conj(H)));
% mesh(real(result * (M*N)))

%G = filter2(H,test);
%g = ifftshift(ifft2(ifftshift(G)));
%mesh(real(g))