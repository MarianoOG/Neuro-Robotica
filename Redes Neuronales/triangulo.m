function [s] = triangulo(x,y,V)

    V = [V,V(:,1)];
    c = (V(:,1)+V(:,2)+V(:,3))/3;
    
    m = zeros(1,3);
    b = zeros(1,3);
    e = zeros(1,3);
    w = zeros(1,4);
    
    for i = 1:3
        % Primera capa:
        [m(i),b(i)] = puntosArecta(V(:,i),V(:,i+1));
        w(i) = neurona(c(1),c(2),[m(i),b(i)]);
        e(i) = neurona(x,y,[m(i),b(i)]);
    end
    % Segunda capa:
    s = -neurona(e,2.5,w);
    
end