function [d,u] = distanciaPuntoASegmento(p,L)
    % Regresa la distancia mas corta entre el punto y un segmento de linea.
    % p es un vector con los valores del punto
    %   [px,py]
    % L es una matriz con los puntos iniciales y finales del segmento 
    %   [ax,ay;bx,by];
    % d es un escalar con el valor de la distancia
    % u es un factor que es menor a 0 si esta del lado de a,
    %                    esta entre 0 y 1 si esta dentro del segmento
    %                    es mayor a 1 si esta del lado de b.
    
    u = ((p-L(1,:)).*(L(2,:)-L(1,:)))/((L(2,:)-L(1,:)).*(L(2,:)-L(1,:)));
    if u<0
        d = norm(p-L(1,:));
    elseif u<1
        d = norm(cross([L(2,:)-L(1,:),0],[p-L(1,:),0]))/norm(L(2,:)-L(1,:));
    else
        d = norm(p-L(2,:));
    end
    
end