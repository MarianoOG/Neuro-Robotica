function untriangulo()

    x = rand(1,100)*6-3;
    y = rand(1,100)*6-3;
    
    v1 = [1,1];
    v2 = [-1,1];
    v3 = [0,-1];
    V = [v1',v2',v3'];
    
    for i = 1:100
        if triangulo(x(i),y(i),V)==-1
            plot(x(i),y(i),'r*'), hold on
        else
            plot(x(i),y(i),'gd'), hold on
        end
    end
    
    V = [V,V(:,1)];
    for i = 1:3
        plot([V(1,i),V(1,i+1)],[V(2,i),V(2,i+1)]), hold on
    end
    axis([-3,3,-3,3])

end