function [ x, y ] = int2circulos( r1, h, k, r2 )
%INT2CIRCULOS regresa los puntos de interseccion entre dos circulos:
%   El primero con centro en el origen y radio r1
%   El segundo con centro (h,k) y radio r2
% Regresa vectores vacios si los circulos no se intersecan
    x = [];
    y = [];
% Comprueba si los dos circulos se intersecan
    if( (r1+r2>=norm([h,k]))&&(abs(r1-r2)<norm([h,k]) ) )
        alpha = (h^2+k^2+r1^2-r2^2)/(2*h);
        A = 1+k^2/h^2;
        B = -2*alpha*k/h;
        C = alpha^2-r1^2;
        y = roots([A,B,C]);
        x = alpha - y*k/h;
    end
end
