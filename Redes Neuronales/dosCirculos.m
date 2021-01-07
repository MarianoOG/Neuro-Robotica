function dosCirculos()

%     x = input('Introduce x: ');
%     y = input('Introduce y: ');
    x = rand(1,1000)*5;
    y = rand(1,1000)*5;
    % Circulo Grande:
    r1 = 1.5; x01 = 2; y01 = 3;
    % Circulo Chico:
    r2 = .5; x02 = 2.5; y02 = 2.5;
    
    % Primera Capa:
    s1 = radial(x,y,r1,x01,y01);
    s2 = radial(x,y,r2,x02,y02);
    for i = 1:length(x)
        % Segunda Capa:
        if neurona(s2(i),s1(i),[1,1])==-1
            plot(x(i),y(i),'rd'),hold on
        else
            plot(x(i),y(i),'b*'),hold on
        end
    end
	dibujarCirculo(r1,x01,y01), hold on
    dibujarCirculo(r2,x02,y02), axis([0,5,0,5])

end