% Valores:
Ubat = 5;
C = 100e-6;
R = 47e3;
theta = 1000;
% Simulacion:
sim integraYdisparaSIM
% Graficas:
figure
    subplot(2,1,1)
        plot(t,I), grid on
        title('I(t)')
        xlabel('Time (s)')
        ylabel('Current (A)')
    subplot(2,1,2)
        plot(t,U), grid on
        title('U(t)')
        xlabel('Time (s)')
        ylabel('Voltaje (V)')