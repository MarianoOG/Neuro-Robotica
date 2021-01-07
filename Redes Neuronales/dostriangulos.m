function dostriangulos()

    % x = input('Introduce x: ');
    % y = input('Introduce y: ');
    x = rand(1,1000)*6-3;
    y = rand(1,1000)*6-3;
    % Triangulo Peque?o:
    v11 = [.7,0];
    v12 = [-.7,0];
    v13 = [0,-1];
    V1 = [v11',v12',v13'];
    % Triangulo Grande:
    v21 = [0,2];
    v22 = [2,-2];
    v23 = [-2,-2];
    V2 = [v21',v22',v23'];
    
    for i = 1:length(x)
        % Doble capa:
        s1 = triangulo(x(i),y(i),V1);
        s2 = triangulo(x(i),y(i),V2);
        % Tercera capa:
        if neurona(s1,s2,[1,1])==-1
            plot(x(i),y(i),'r*'), hold on
        else
            plot(x(i),y(i),'gd'), hold on
        end
    end
    
    dibujarTriangulo(V1);
    dibujarTriangulo(V2);
    axis([-3,3,-3,3])

end