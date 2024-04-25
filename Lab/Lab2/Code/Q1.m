data80 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\2 pratica\degmotor80.dat');
t80 = data80(:, 1);  % Para PWM 80
e80=data80(:,2);
u80 = data80(:, 3);  
%plot(t80,[e80, u80])

pwm = [40 60 90];

s=tf('s');
Gs = 1.12*exp(-s*0.2)/(0.8*s+1);
Gd = c2d(Gs,0.1,'zoh')
  
vec = (0:0.1:10);

% Customize x-axis tick values
xtick_values = 0:0.5:10;
set(gca, 'XTick', xtick_values);

% Customize y-axis tick values
ytick_values = 0:5:max(y);
set(gca, 'YTick', ytick_values);

%comente o codigo abaixo para evidenciar os plots acima

% comparacao com o processo real em pwm 40, 60 e 90%
%para pwm 40%
data40 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor40.dat');
t40 = data40(:, 1);  % Para PWM 40
e40=data40(:,2);
u40 = data40(:, 3);  

ref = pwm(1)*1/e40(1)*e40;

y=step(pwm(1)*Gd, t40); 
 
figure(1);
[ax, h1, h2] = plotyy(t40, y, t40, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(1)), '% (Modelo discreto)'));
grid on;

figure(2);
[ax, h1, h2] = plotyy(t40, u40, t40, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(1)), '% (Experimental)'));
grid on;

figure(3);
plot(t40, u40-y);
xlabel('Tempo');
ylabel('Erro');
legend('Erro instantâneo', 'Location', 'Southeast');
title(strcat('Erro em resposta ao degrau com PWM ',num2str(pwm(1)), '%'));
grid on;



%para pwm 60%
data60 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor60.dat');
t60 = data60(:, 1);  % Para PWM 60
e60=data60(:,2);
u60 = data60(:, 3);  


ref = pwm(2)*1/e60(1)*e60;

y=step(pwm(2)*Gd, t60); 
 
figure(4);
[ax, h1, h2] = plotyy(t60, y, t60, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(2)), '% (Modelo discreto)'));
grid on;

figure(5);
[ax, h1, h2] = plotyy(t60, u60, t60, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(2)), '% (Experimental)'));
grid on;

figure(6);
plot(t60, u60-y);
xlabel('Tempo');
ylabel('Erro');
legend('Erro instantâneo', 'Location', 'Southeast');
title(strcat('Erro em resposta ao degrau com PWM ',num2str(pwm(2)), '%'));
grid on;




data90 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor90.dat');
t90 = data90(:, 1);  % Para PWM 90
e90=data90(:,2);
u90 = data90(:, 3);  


ref = pwm(3)*1/e90(1)*e90;

y=step(pwm(3)*Gd, t90); 
 
figure(7);
[ax, h1, h2] = plotyy(t90, y, t90, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(3)), '% (Modelo discreto)'));
grid on;

figure(8);
[ax, h1, h2] = plotyy(t90, u90, t90, ref);

% Customize the appearance of the plot 2
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('Saída','Referência', 'Location', 'Southeast');
title(strcat('Resposta ao degrau com PWM ',num2str(pwm(3)), '% (Experimental)'));
grid on;


figure(9);
plot(t90, u90-y);
xlabel('Tempo');
ylabel('Erro');
legend('Erro instantâneo', 'Location', 'Southeast');
title(strcat('Erro em resposta ao degrau com PWM ',num2str(pwm(3)), '%'));
grid on;
