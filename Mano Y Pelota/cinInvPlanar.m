function [q,q2] = cinInvPlanar(x,y,l1,l2)
    c = (x^2+y^2-l1^2-l2^2)/(2*l1*l2);
    s = sqrt(1-c^2);
    q = zeros(1,2);
    q(1) = atan2(y,x) - atan2(l2*s,l1+l2*c);
    q(2) = atan2(s,c);
    q2(1) = atan2(y,x) - atan2(-l2*s,l1+l2*c);
    q2(2) = atan2(-s,c);
    if(q(1)<0), q(1) = q(1) + 2*pi; end
	if(q(2)<0), q(2) = q(2) + 2*pi; end
    if(q2(1)<0), q2(1) = q2(1) + 2*pi; end
	if(q2(2)<0), q2(2) = q2(2) + 2*pi; end
end