function unCirculo()

    x = rand(1,100)*3;
    y = rand(1,100)*3;
    r = 1;
    x0 = 1;
    y0 = 1;
    
    s = radial(x,y,r,x0,y0);

    for i = 1:length(x)
        if s(i)==-1
            plot(x(i),y(i),'rd'),hold on
        else
            plot(x(i),y(i),'b*'),hold on
        end
    end
	dibujarCirculo(r,x0,y0)

end