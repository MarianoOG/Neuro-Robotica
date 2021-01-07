function [pi] = obtenerPuntosInteres2DOF(p,l,c)
    pi = zeros(4,2);
    if c
        q = cinInvPlanar(p(1),p(2),l(1),l(2));
    else
        q = cinInvPlanar2(p(1),p(2),l(1),l(2));
    end
    pi(4,:) = p;
    pi(2,:) = [l(1)*cos(q(1)),l(1)*sin(q(1))];
    pi(1,:) = pi(2,:)/2;
    pi(3,:) = (pi(4,:) + pi(2,:))/2;
end