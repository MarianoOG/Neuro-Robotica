% Reiniciar
clear all; close all;

% Definir par?metros 'q1' y 'q2'
q = 0:0.05:pi;
[q1,q2] = meshgrid(q,q);
q1 = q1(:)';
q2 = q2(:)';

% Definir posiciones a partir de parametros 'x' y 'y'
l = [2,1.5];
x = l(1)*cos(q1) + l(2)*cos(q1+q2);
y = l(1)*sin(q1) + l(2)*sin(q1+q2);

% Area de trabajo
plot(x,y,'*')

% Definir entradas y salidas de red neuronal
in = [x;y];
out = [q1;q2];
