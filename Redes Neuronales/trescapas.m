function trescapas()

    x = rand(1,100)*100-50;
    y = rand(1,100)*100-50;
    m1 = 1;
    b1 = 10;
    m2 = -2;
    b2 = 20;
    
    figure
    for i = 1:100
        % 1era capa:
        s11 = neurona(x(i),y(i),[m1,b1]);
        s12 = neurona(x(i),y(i),[m2,b2]);
        % 2da capa:
        s21 = neurona(s11,s12,[-1,1/2]);
        s22 = neurona(s11,s12,[-1,-1/2]);
        % 3era capa:
        if neurona(s21,s22,[1,1/2])==1
            plot(x(i),y(i),'ro'), hold on
        else
            plot(x(i),y(i),'b*'), hold on
        end
    end
    plot(-50:50,m1*(-50:50)+b1,'k'), hold on
    plot(-50:50,m2*(-50:50)+b2,'k'), axis([-50,50,-50,50])

end