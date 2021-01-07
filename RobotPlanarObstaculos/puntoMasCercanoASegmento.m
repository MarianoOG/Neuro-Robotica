function [c] = puntoMasCercanoASegmento(p,L)
    % Regresa el punto mas cercano del segmento de linea a otro punto.
    % p es un vector con los valores del punto
    %   [px,py]
    % L es una matriz con los puntos iniciales y finales del segmento 
    %   [ax,ay;bx,by];
    % c es un vector con el valor del punto mas cercano

    u = ((p-L(1,:)).*(L(2,:)-L(1,:)))/((L(2,:)-L(1,:)).*(L(2,:)-L(1,:)));
    if u<=0
        c = L(1,:);
    elseif u<1
        m1 = ( L(1,2)-L(2,2) )/( L(1,1)-L(2,1) );
        b1 = L(1,2) - m1*L(1,1);
        m2 = -1/m1;
        b2 = p(2) - m2*p(1);
        c = ([-m1,1;-m2,1]\[b1;b2])';
    else
        c = L(2,:);
    end
    
end