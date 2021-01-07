function [ Pq, P1 ] = estadoPulgar( P, h, k, r )
%ESTADOPULGAR Devuelve los parametros para la posicion del robot pulgar
    Pq = [0,0];
    l = sqrt(P(2)^2+r^2);
    [a,b] = int2circulos(P(1),h,k,l);
    % Elegir punto m?s alto como el que tenga menor pendiente
    if (isempty(a))
        Pq = [0,0];
        P1 = [];
    else
        if (atan2(a(2),b(2))<atan2(a(1),b(1)))
            x = a(2);
            y = b(2);
        else
            x = a(1);
            y = b(1);
        end
        % Encontrar parametros del robot
        Pq(1) = atan2(y,x);
        alpha = atan2(k-y,h-x);
        psi = atan2(r,P(2));
        Pq(2) = -(Pq(1)-psi-alpha);
        P1 = [x,y]';
    end
end
