clear
I = [];
x = [];
for j=1:40
    for i=1:3
        %I(:,:,i) = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        Itmp = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        Itmp = im2double(Itmp);
        x = [x Itmp(:)];
    end
end
%I = uint8(I);
[M N qtd] = size(Itmp);

%u = zeros(M,N);
%u(round(M/2),round(N/2)) = 255;

u = zeros(120,1);
u(1:3) = 1;

%U = zeros(M*N,400);
%U((M*N)/2,:) = 255;
h = x * inv(x' * x) * u;
%H = sum(h,2);

test = imread('s1/10.pgm');
test = im2double(test);

lena = imread('lena.pgm');
lena = im2double(lena);

%result = h' * test
H = reshape(h, size(Itmp));

%imshow(uint8(255*mat2gray(testimg)))