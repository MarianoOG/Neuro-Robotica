%TORQUESSOBRELINEA Grafica los torques generados por cada motor

% Iniciar herramientas
close all; clc;
initPeterCorkeToolboox();

% Robot de 3GDL
l = [3,3,3];
L1 = Link('d',0,'a',l(1),'alpha',0);
L2 = Link('d',0,'a',l(2),'alpha',0);
L3 = Link('d',0,'a',l(3),'alpha',0);
robot = SerialLink([L1, L2, L3],'name','3GDL');

% Linea
t = linspace(0,1,100);
x = 6*ones(size(t));
y = 2*t+1;

% Jacobiano y fuerzas
J = inline('3*[-sin(q1)-sin(q1+q2), -sin(q1+q2), 0; cos(q1)+cos(q1+q2), cos(q1+q2), 0]','q1','q2');
F = [10, 0]';

% Parametros
% figure
% plot(x,y), hold on
q = zeros(100,3);
tau = zeros(100,3);
for i = 1:100
    q(i,1:2) = cinInvPlanar(x(i)-3,y(i),l(1),l(2));
    q(i,3) = - q(i,1) - q(i,2);
    % robot.plot(q(i,:))
    tau(i,:) = J(q(i,1),q(i,2))'*F;
end

figure
    subplot(3,1,1)
        plot(2*t+1,tau(:,1))
        title(['q1 - Tau max = ',num2str(max(tau(:,1)))])
    subplot(3,1,2)
        plot(2*t+1,tau(:,2))
        title(['q2 - Tau max = ',num2str(max(tau(:,2)))])
	subplot(3,1,3)
        plot(2*t+1,tau(:,3))
        title(['q3 - Tau max = ',num2str(max(tau(:,3)))])
        