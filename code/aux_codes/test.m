maximo = [];
for j=1:40
    for i=1:10       
        test = imread(['s',num2str(j),'/',num2str(i),'.pgm']);
        test = im2double(test);
        test = fft2(test);

        result = ifftshift(ifft2(test .* conj(H)));
        maximo = [maximo max(real(result(:)))];
    end
end

plot(1:400,maximo*10304)  