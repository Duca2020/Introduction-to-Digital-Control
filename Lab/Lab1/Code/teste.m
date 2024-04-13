s=tf('s');

input_velocity = [20, 30, 60, 90];
dc_gains = [1.72,1.44,1.21,1.03];
time_constants = [1.1,0.9,0.8,0.6];
tsampling = 0.1;


% Iterate over each pair of time constants and DC gains
for i = 1:numel(time_constants)
    % Create a transfer function using the current time constant and DC gain
    Gs(i) = tf(dc_gains(i), [time_constants(i) 1]);
    Gd(i) = c2d(Gs(i), tsampling);
end

%com os modelos prontos, iremos aplicar um degrau correspondente a cada pwm

% Para o modelo continuo:

 for i = 1:numel(time_constants)
     h = figure(i);  
     hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
     plot(input_velocity(i)*(step(Gs(i))));
     title('Resposta ao degrau (Modelo contínuo)');
     xlabel('Tempo (s)');
     ylabel('Velocidade (rps)');
     legend('velocidade de saída', 'Location', 'southeast');
     grid on;

     
  
      h = figure(i+4);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(step(input_velocity(i)*d2c(Gd(i), 'tustin')));
%     yd = input_velocity(i)*step(Gd(i));
%     stem(yd);
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('velocidade de saída', 'Location', 'southeast');
      title('Resposta ao degrau (Modelo discreto)');
      grid on
 
      h = figure(i+8);  
      hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
      plot(input_velocity(i)*(step(Gs(i)))-step(input_velocity(i)*d2c(Gd(i), 'tustin')));
      xlabel('Tempo (s)');
      ylabel('Velocidade (rps)');
      legend('Erro de modelagem', 'Location', 'southeast');
      title('Erro de saída entre modelo contínuo e discreto');
      grid on
    
 end

