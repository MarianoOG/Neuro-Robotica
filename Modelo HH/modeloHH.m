% Valores:
Cm = 1e-6/1e-4;
GNAmax = 120e-3;
GKmax = 36e-3;
GL = 0.3e-3;
Vr = -65;
VNA = Vr + 115;
VK = Vr - 12;
VL = Vr + 10.613;
% Simulacion:
sim HH
% Graficas:
figure
    subplot(2,1,1)
        plot(t,I), grid on
        title('I(t)')
        xlabel('Time (s)')
        ylabel('Current (A)')
    subplot(2,1,2)
        plot(t,Vm), grid on
        title('Vm(t)')
        xlabel('Time (s)')
        ylabel('Voltaje (mV)')