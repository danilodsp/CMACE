% Fast Gaussian Transform

function G = fgt(x, y, q, h, e)

Nb = length(x);
Mc = length(y);

G = zeroz(1, Mc);
p = 20;
%a = 1:20;

%xc = sqrt(2)*r*h*(a + 1/2);

for l=1:Mc
    for a=1:p
        xc = sqrt(2)*r*h*(a + 1/2);
        
        A = 0;
        for i=1:Nb
            A = A + q(i)*((x(i)-xc)/h)^a;
        end
        
        G = G + (1/factorial(a))*A ;
    end
end

end
