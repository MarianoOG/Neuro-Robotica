function [s] = radial(x,y,r,x0,y0)
  
    W = [1,1,0];
    s = zeros(1,length(x));
    
    for i = 1:length(x)
        X = [(x(i)-x0)^2,(y(i)-y0)^2];
        s(i) = neurona(X,r.^2,W);
    end
    
 
end