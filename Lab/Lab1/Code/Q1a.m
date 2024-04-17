%Código 1a de Resposta ao Degrau em Malha Aberta com PWM 0, 10, 20, 30, 40,
%50, 60, 70, 80, 90, 100

global SerPIC


%Limpar variáveis do Workspace - INICIO
varlist = {'u','y', 'Tempo'};
clear(varlist{:})
clf(figure(1))
path_fig = 'C:\Users\ACER\Desktop\Laboratorio Controle Digital\Pratica 1\Imagens'


 %#### Inicio Configura Saída Gráfica
  h = figure(1);  
  hLine1 = line(nan, nan, 'Color','red','linewidth', 2);
  title('Velocidade Motor DC');
  xlabel('Tempo (s)');
  ylabel('Velocidade (rps)');
  legend('velocidade', 'Location', 'southeast');
  
  grid on;
  
    %#### Fim Configura Saída Gráfica
    
    Ts = 0.1;  %Determinação do período de amostragem
%Dados da estimação pela resposta ao degrau

set_pwm(0); %incia zerando PWM
pause(5);


pwm=10; %coloca o valor desejado para PWM [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

Qde_amostras = 100; %Quantidade de amostras do gráfico
 for k=1:Qde_amostras u(k)=pwm;
 end
 
 
 
 for k = 1:Qde_amostras
       y(k) =recebe_velocidade; %Recebe o valor medido de armazena     
        if u(k)>100 u(k)=100; end
        if u(k)<0 u(k)=0; end;
        set_pwm(u(k));
        
%###Saída Gráfica
      x1 = get(hLine1, 'XData');  
      y1 = get(hLine1, 'YData');  
      x1 = [x1 k*Ts];  
      y1 = [y1 y(k)];  
      set(hLine1, 'XData', x1, 'YData', y1);  
%###Fim Saída Gráfica

       Tempo(k) = k*Ts;
       pause(Ts);
 end

 %filename = 'figure1.png';
  %Usando o tempo atual para nomear, outra forma eh usar a nomeacao manual
  %acima
   filepath = strcat(path_fig, '\', datestr(now, 'HHMMSS'), '.png');
  saveas(gcf, filepath);
 
%set_pwm(0);
%{
clf(figure(2))
figure(2);
title('Sinal de Referência e saída');

yyaxis left
plot(Tempo,y,'linewidth', 2)
ylabel('y(t)');

yyaxis right
plot(Tempo,u,'linewidth', 2) 
ylabel('u(t)');

xlabel('Tempo (s)');
%}

clf(figure(2))
figure(2);
[ax, h1, h2] = plotyy(Tempo, y, Tempo, u);

% Customize the appearance of the plot
set(h1, 'LineWidth', 2);
set(h2, 'LineWidth', 2);
xlabel('Tempo');
ylabel(ax(1), 'y(t)');
ylabel(ax(2), 'u(t)');
legend('saida', 'referencia', 'Location', 'southeast');
grid on;

title(strcat('Sinal de Referência e Saída com PWM 85%'));

  %filename = 'figure2.png';
  %Usando o tempo atual para nomear, outra forma eh usar a nomeacao manual
  %acima
  
  filepath = strcat(path_fig, '\', datestr(now, 'HHMMSS'), '.png');
  saveas(gcf, filepath);
  
saidas=[Tempo; u; y]';
axis([0 Qde_amostras*Ts 0 120])
axis([0 Qde_amostras*Ts 0 inf])

path = strcat('C:\Users\ACER\Desktop\Laboratorio Controle Digital\Pratica 1\', 'degmotor85.dat');

save('-ascii', path, 'saidas');