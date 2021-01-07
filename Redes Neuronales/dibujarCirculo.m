function dibujarCirculo(r,x0,y0)

    t = linspace(x0-r,x0+r,1000);
    y1 = sqrt(r.^2-(t-x0).^2) + y0;
    y2 = -sqrt(r.^2-(t-x0).^2) + y0;

    plot(t,y1,'k',t,y2,'k');

end