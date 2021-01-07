%% Robot Planar Esquivando linea en espacio de configuracion:
close all
initPeterCorkeToolboox();

% Crear objeto de robot:
l = [3,3];
L1 = Link('d',0,'a',l(1),'alpha',0);
L2 = Link('d',0,'a',l(2),'alpha',0);
robot = SerialLink([L1, L2],'name','Planar');

% Posicion final e inicial
q0 = input('Ingrese vector q0: ');
p0 = robot.fkine(q0)*[0,0,0,1]';
qf = input('Ingrese vector qf: ');
pf = robot.fkine(qf)*[0,0,0,1]';

% Obstaculo Linea
L = [1,1;2,2];
xl = linspace(L(1,1),L(2,1),100);
yl = linspace(L(1,2),L(2,2),100);
obstaculo = zeros(4,100);
for i = 1:100
    obstaculo(:,i) = robot.fkine([xl(i),yl(i)])*[0,0,0,1]';
end

% Fondo de animaci?n:
alpha = linspace(0,2*pi,100);
subplot(1,2,1)
    plot(6*cos(alpha),6*sin(alpha),'b'); hold on
    plot(obstaculo(1,:),obstaculo(2,:),'r');
    plot(p0(1),p0(2),'bo');
    plot(pf(1),pf(2),'bx');     
subplot(1,2,2)
    plot(xl,yl,'r'); hold on
    plot(q0(1),q0(2),'bo');
    plot(qf(1),qf(2),'bx');     
    axis([0,2*pi,0,2*pi])

% Animacion
epsilon = 0.03; % Condicion de paro
q = q0;
while(1)
    p = robot.fkine(q)*[0,0,0,1]';
    subplot(1,2,1)
        plot(p(1),p(2),'b*');
        title(norm(p-pf))
    subplot(1,2,2)
        plot(q(1),q(2),'b*');
        title(norm(q-qf))
    if norm(q-qf)<epsilon, break; end
    q = siguientePuntoEspConfig(q,qf,L);
    pause(.5);
end
