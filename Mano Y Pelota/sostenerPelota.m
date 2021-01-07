% SOSTENERPELOTA Hace que dos robots de 2GDL y 3GDL respectivamente
% se coloquen en posiciones adecuadas para el agarre de una pelota.

% Iniciar herramientas
close all; clc;
initPeterCorkeToolboox();

% Robot Dedo Pulgar
P = [3,2];
LP1 = Link('d',0,'a',P(1),'alpha',0);
LP2 = Link('d',0,'a',P(2),'alpha',0);
pulgar = SerialLink([LP1, LP2],'name','Pulgar');

% Robot Dedo Indice
D = [3,2,1];
LD1 = Link('d',0,'a',D(1),'alpha',0);
LD2 = Link('d',0,'a',D(2),'alpha',0);
LD3 = Link('d',0,'a',D(3),'alpha',0);
indice = SerialLink([LD1, LD2, LD3],'name','Indice');

% Pelota
h = 3;
k = -3;
r = 1;
alpha = (0:0.5:360)*pi/180;

% Posicionar robots
[Pq,P1] = estadoPulgar(P,h,k,r);
Pfin = pulgar.fkine(Pq)*[0,0,0,1]';
Dq = estadoIndice(D,P1,Pfin,[h,k]');

% Graficar
plot3(r*cos(alpha)+h,r*sin(alpha)+k,0*alpha); hold on
pulgar.plot(Pq);
indice.plot(Dq);