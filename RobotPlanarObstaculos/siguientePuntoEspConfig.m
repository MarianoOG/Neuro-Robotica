function [q] = siguientePuntoEspConfig(q0,qf,L)
    % Regresa el siguiente punto de la trayectoria
    % q0 es un vector con la posicion actual
    % qf es el vector con la posicion deseada
    % L es el obstaculo (un segmento de l?nea).
    
    d = 2; % Umbral del campo atractivo
    z = 3; % Factor de escalamiento del campo atractivo
    Pf = norm(qf-q0);
    Fatt = z*(qf-q0)*(Pf<=d) + d*z*(qf-q0)*(Pf>d)/Pf;
    
    P0 = .5; % Umbral de campo de repulsion
    n = 1; % Factor de escalamiento del campo de repulsion;
    b = puntoMasCercanoASegmento(q0,L);
    Pq = norm(q0-b);
    Frep = n*(1/Pq-1/P0)*(q0-b)*(Pq<=P0)/Pq^3;
    
    F = Fatt + Frep;
    
    alpha = 0.05; % Tasa de aprendizaje
    q = q0 + alpha*F/norm(F);
    
end