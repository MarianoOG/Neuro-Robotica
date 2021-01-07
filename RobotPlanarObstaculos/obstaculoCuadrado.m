% Obstaculo cuadrado en espacio de configuracion:
p = 30;

for x = linspace(3,4,p)
    for y = linspace(2,3,p)
        q = cinInvPlanar(x,y,3,3);
        plot(q(1),q(2),'r*'), hold on
        q = cinInvPlanar2(x,y,3,3);
        plot(q(1),q(2),'r*'), hold on
    end
end
grid on, axis([0,2*pi,0,2*pi])