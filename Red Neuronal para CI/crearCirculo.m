%CREARCIRCULO Regresa los valores de q1 y q2 para la posicion (x,y)

% Iniciar programa
clear all; clc;
initPeterCorkeToolboox();
load NEURONA;

% Parametros del circulo
c = [-2,1];
r = 1;
alpha = 0:0.05:2*pi;
x = r*cos(alpha) + c(1);
y = r*sin(alpha) + c(2);

% Crear Robot
l = [2,1.5];
L1 = Link('d',0,'a',l(1),'alpha',0);
L2 = Link('d',0,'a',l(2),'alpha',0);
robot = SerialLink([L1, L2],'name','Planar');

% CI y graficar
figure
for i = 1:length(alpha)    
    plot(x,y); hold on;
    robot.plot(net([x(i);y(i)])'); hold off;
end
