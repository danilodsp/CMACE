test = fft(vetorNormals(1,:));
G = filter2(H,test);
g = ifftshift(ifft2(G));
plot(real(g))