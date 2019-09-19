function c = correlation(x,y)

mediax = mean(x(:));
mediay = mean(y(:));

c = ((x - mediax).*(y - mediay)) ./ (sqrt(((x - mediax).^2) .* ((y - mediay).^2)));

end
