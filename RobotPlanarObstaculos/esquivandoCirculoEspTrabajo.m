%% Robot Planar Esquivando linea en espacio de configuracion:
close all
initPeterCorkeToolboox();

% Crear objeto de robot:
l = [3,3];
L1 = Link('d',0,'a',l(1),'alpha',0);
L2 = Link('d',0,'a',l(2),'alpha',0);
robot = SerialLink([L1, L2],'name','Planar');

% Posicion final e inicial
ref = 0;
p0 = input('Ingrese posicion inicial: ');
p0 = obtenerPuntosInteres2DOF(p0,l,ref);
pf = input('Ingrese posicion final: ');
pf = obtenerPuntosInteres2DOF(pf,l,ref);

% Mapeo de posiciones en espacio de configuracion
q0 = zeros(4,2);
qf = q0;
for i = 1:4
    if ref
        q0(i,:) = cinInvPlanar(p0(i,1),p0(i,2),l(1),l(2));
        qf(i,:) = cinInvPlanar(pf(i,1),pf(i,2),l(1),l(2));
    else
        q0(i,:) = cinInvPlanar2(p0(i,1),p0(i,2),l(1),l(2));
        qf(i,:) = cinInvPlanar2(pf(i,1),pf(i,2),l(1),l(2));
    end
end

% Obstaculo circulo
C = [1,1,0.5];
alpha = linspace(0,2*pi,100);
xc = C(1)+C(3)*cos(alpha);
yc = C(2)+C(3)*sin(alpha);
obst = zeros(2,200);
for i = 1:100
    obst(:,i) = cinInvPlanar(xc(i),yc(i),l(1),l(2));
    obst(:,i+100) = cinInvPlanar2(xc(i),yc(i),l(1),l(2));
end

% Fondo de animacion:
subplot(1,2,1)
    plot(6*cos(alpha),6*sin(alpha),'k'); hold on
    plot(xc,yc,'r');
    plot(p0(:,1),p0(:,2),'bo');
    plot(pf(:,1),pf(:,2),'bx');
subplot(1,2,2)
    plot(obst(1,1:100),obst(2,1:100),'r'); hold on
    plot(obst(1,101:200),obst(2,101:200),'r');
    plot(q0(:,1),q0(:,2),'bo');
    plot(qf(:,1),qf(:,2),'bx');     
    axis([0,2*pi,0,2*pi])
    
% Animacion
epsilon = 0.03; % Condicion de paro
p = p0;
q = q0;
while(1)
    subplot(1,2,1)
        plot(p(:,1),p(:,2),'b*');
        title(norm(p-pf))
    subplot(1,2,2)
        plot(q(:,1),q(:,2),'b*');
        title(norm(q-qf))
    if norm(p-pf)<epsilon, break; end
    p = siguienteEstadoEspTrabajo(p,pf,C);
    p = obtenerPuntosInteres2DOF(p,l,ref);
    for i = 1:4
        if ref
            q(i,:) = cinInvPlanar(p(i,1),p(i,2),l(1),l(2));
        else
            q(i,:) = cinInvPlanar2(p(i,1),p(i,2),l(1),l(2));
        end
    end
    pause(.5);
end

beep
