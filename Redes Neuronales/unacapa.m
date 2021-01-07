function unacapa()

    x = rand(1,100)*100-50;
    y = rand(1,100)*100-50;
    m = 10;
    b = 5;
    
    figure
    for i = 1:100
        if neurona(x(i),y(i),[m,b])==1
            plot(x(i),y(i),'ro'), hold on
        else
            plot(x(i),y(i),'b*'), hold on
        end
    end
    plot(-50:50,m*(-50:50)+b,'k'), axis([-50,50,-50,50])
    

end