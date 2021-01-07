function [p] = siguienteEstadoEspTrabajo(p0,pf,C)
    % Regresa el siguiente estado de la trayectoria
    % p0 es una matriz con las posiciones de los puntos de interes actuales
    %   p0 = [a1x,a1y;a2x,a2y;...;anx,any]
    % pf es una matriz con las posiciones de los puntos de interes deseados
    %   pf = [b1x,b1y;b2x,b2y;...;bnx,bny]
    % C es un vector con las especificaciones del obstaculo
    %   C = [cx,cy,r]
    % p es una vector con la posicion actualizada del ultimo punto de
    % interes
    %   p = [px,py]
        
    l = size(p0,1);
    
    % Fuerzas atractivas
    d = 1; % Umbral del campo atractivo
    z = 3; % Factor de escalamiento del campo atractivo
    Pf = zeros(1,l);
    Fatt = zeros(l,2);
    for i = 1:l
        Pf(i) = norm(pf(i,:)-p0(i,:));
        Fatt(i,:) = z*(pf(i,:)-p0(i,:))*(Pf(i)<=d) + ...
            d*z*(pf(i,:)-p0(i,:))*(Pf(i)>d)/Pf(i);
    end
    
    % Fuerzas repulsivas
    P0 = 0.5; % Umbral de campo de repulsion
    n = 1; % Factor de escalamiento del campo de repulsion;
    b = puntoMasCercanoACirculo(p0,C);
    Pq = zeros(1,l);
    Frep = zeros(l,2);
    for i = 1:l
        Pq(i) = norm(p0(i,:)-b(i,:));
        Frep(i,:) = n*(1/Pq(i)-1/P0)*(p0(i,:)-b(i,:))*(Pq(i)<=P0)/Pq(i)^3;
    end
    
    % Suma total de fuerzas y resultado
    F = sum(Fatt,1) + sum(Frep,1);
    alpha = 0.05; % Tasa de aprendizaje
    p = p0(l,:) + alpha*F/norm(F);
    
end