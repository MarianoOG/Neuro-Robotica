function [s] = neurona(x,y,W)
    
    X = [x,1];
    s = y - W*X';
    s = sign(s);
    
end