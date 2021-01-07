function [ Dq ] = estadoIndice( D, P1, Pfin, c )
%ESTADOINDICE Produce los parametros para posicionar al robot indice
    if isempty(P1)
        Dq = [0,0,0];
        disp('La pelota no se puede alcanzar')
    else
% Punto final del indice
        Pfin = Pfin(1:2);
        rv = c - Pfin;
        Dfin = Pfin + 2*rv;
% Punto de segunda junta
        paralela = (P1-Pfin)/norm(P1-Pfin);
        D2 = Dfin + D(3)*paralela;
        Dq = cinInvPlanar(D2(1),D2(2),D(1),D(2));
        Dq(3) = -(Dq(1)+Dq(2)-atan2(Dfin(2)-D2(2),Dfin(1)-D2(1)));
    end
end

