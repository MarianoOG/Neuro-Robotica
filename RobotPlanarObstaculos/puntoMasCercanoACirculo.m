function [b] = puntoMasCercanoACirculo(p,C)
    % Regresa el cojunto de puntos mas cercanos a los puntos de interes
    % p es una matriz con los valores de los puntos de interes
    %   p = [p1x,p1y;p2x,p2y;...;pnx,pny]
    % C es un vector con las coordenadas y el radio del circulo
    %   C = [cx,cy,r]
    % b es una matriz con los valores de los puntos mas cercanos
    %   b = [b1x,b1y;b2x,b2y;...;bnx,bny]

    b = zeros(size(p));
    for i = 1:size(p,1)
        t = C(1:2) - p(i,:);
        r = C(3)*t/norm(t);
        b(i,:) = C(1:2) - r;
    end
    
end