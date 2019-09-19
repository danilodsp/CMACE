jg = 20; % Largura da janela grande
jp = 5; % Largura da janela pequena

peak_taxa = [];
elementos_vetor = [];

for j=1:40
    for i=1:10       
        test = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        test = im2double(test);
        test = fft2(test);

        result = ifftshift(ifft2(test .* conj(H)));
        result = real(result)*10304;
        for w=(-jg):jg
            if (w<(-jp))||(w>jp)
                elementos_vetor = [elementos_vetor real(result((112/2)+w,(92/2)+w))];
            end
        end
        tmp = (result(112/2,92/2) - mean(elementos_vetor)) / var(elementos_vetor);
        elementos_vetor = [];
        peak_taxa = [peak_taxa tmp];
    end
end

plot(1:400,peak_taxa)
