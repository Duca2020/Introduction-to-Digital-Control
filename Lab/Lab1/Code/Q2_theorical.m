s=tf('s');

data20 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor20.dat');
x20 = data20(:, 1);  % for pwm 20
y20 = data20(:, 3);  

data40 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor40.dat');
x40 = data40(:, 1);  % for pwm 40
y40 = data40(:, 3);  

data60 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor60.dat');
x60 = data60(:, 1);  % for pwm 60
y60 = data60(:, 3);  

data90 = importdata('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Fixed\degmotor90.dat');
x90 = data90(:, 1);  % for pwm 90
y90 = data90(:, 3);  

x = {x20, x40, x60, x90};
y = {y20, y40, y60, y90};

input_velocity = [20, 30, 60, 90];
dc_gains = [1.71,1.44,1.22,1.03];
time_constants = [1.1,0.9,0.8,0.6];
dead_times = [0.2, 0.1, 0.1, 0];
tsampling = 0.1
pwm = {'20', '30', '60', '90'};

% Iterate over each pair of time constants and DC gains
for i = 1:numel(time_constants)
    % Create a transfer function using the current time constant and DC gain
    Gs(i) = tf(dc_gains(i)*exp(-dead_times(i)), [time_constants(i) 1]);
    Gd(i) = c2d(Gs(i), tsampling);
end

%com os modelos prontos, iremos aplicar um degrau correspondente a cada pwm

% Para o modelo continuo:

 for i = 1:numel(time_constants)
     h = figure(i);  
     hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
     plot(input_velocity(i)*(step(Gs(i),x{i})));
     title(strcat('Resposta ao degrau MA (modelo contínuo) para PWM ',pwm{i},'%'));
     xlabel('Tempo (s)');
     ylabel('Velocidade (rps)');
     legend('velocidade de saída', 'Location', 'southeast');
     grid on;
     saveas(gcf, strcat('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Imagens\2)\modelagens\','Resposta ao degrau MA (modelo contínuo) para PWM ',pwm{i},'%.png'));
     
  
      h = figure(i+4);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(input_velocity(i)*step(d2c(Gd(i), 'tustin'),x{i}));
%     yd = input_velocity(i)*step(Gd(i));
%     stem(yd);
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('velocidade de saída', 'Location', 'southeast');
     title(strcat('Resposta ao degrau MA (Modelo discreto) para PWM ',pwm{i},'%'));
      grid on
      saveas(gcf, strcat('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Imagens\2)\modelagens\','Resposta ao degrau MA (modelo discreto) para PWM ',pwm{i},'%.png'));

      h = figure(i+8);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(x{i}, y{i} - input_velocity(i)*(step(Gs(i), x{i})));
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('Erro de modelagem (modelo contínuo)', 'Location', 'southeast');
      title(strcat('Erro de saída com modelo contínuo em PWM ', pwm{i}, '%'));
      grid on
      saveas(gcf, strcat('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Imagens\2)\modelagens\','Erro de saída com modelo contínuo em PWM ',pwm{i},'%.png'));

       h = figure(i+12);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(x{i}, y{i} - input_velocity(i)*step(d2c(Gd(i), 'tustin'), x{i}));
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('Erro de modelagem (modelo discreto)', 'Location', 'southeast');
      title(strcat('Erro de saída com modelo discreto em PWM ', pwm{i}, '%'));
      grid on
      saveas(gcf, strcat('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Imagens\2)\modelagens\','Erro de saída com modelo discreto em PWM ',pwm{i},'%.png'));

    
      h = figure(i+16);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(x{i}, input_velocity(i)*(step(Gs(i), x{i})) - input_velocity(i)*step(d2c(Gd(i), 'tustin'),x{i}));
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('Erro contínuo - discreto', 'Location', 'southeast');
      title(strcat('Erro de entre modelagens em PWM ', pwm{i}, '%'));
      grid on
      saveas(gcf, strcat('C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\1 pratica\Imagens\2)\modelagens\','Erro de entre modelagens em PWM ',pwm{i},'%.png'));

 end

