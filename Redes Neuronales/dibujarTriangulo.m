function dibujarTriangulo(V)

    V = [V,V(:,1)];
    for i = 1:3
        plot([V(1,i),V(1,i+1)],[V(2,i),V(2,i+1)]), hold on
    end

end