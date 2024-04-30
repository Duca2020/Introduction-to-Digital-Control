global SerPIC
clear();

path_fig = 'C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\2 pratica\Imagens';

qntAmostras = 300;
Ts = 0.1; %Periodo de amostragem

for k=1:qntAmostras 
    r(k) = 80;
    tempo(k) = k*Ts;
    y(k)=0;
end

e(1)=r(1)-y(1);
e(2)=r(2)-y(2);
e(3)=r(3)-y(3);

u(1)=0; 
u(2)=0;
u(3)=0;
%Inicio do loop de acionamento;


% ---------------------------------------------------------------------
ganho = 4.95;    %Varie o ganho para descobrir o ganho critico da planta
% ---------------------------------------------------------------------
for k = 4:qntAmostras
    y(k) = 0.8825*y(k-1)+ 0.1316*u(k-3);% EDO em malha aberta
    e(k) = r(k) - y(k);
    u(k) = ganho * e(k);
    if(u(k)>100) u(k) = 100; end
    if(u(k)<0)   u(k) = 0;   end
      
end

saidas = [tempo,u,y];

figure(1);
plot(tempo, y, tempo, u);
title('Motor DC em malha fechada (Experimental)');
legend('Saida','Controle', 'Location', 'southeast');
xlabel('tempo(s)');
ylabel('Velocidade(RPS)');
grid on;
filepath = strcat(path_fig, '\Motor DC em malha fechada (Experimental - 2ZN).png');
saveas(gcf, filepath);


% Algoritmo PID Discreto/Digital 2 metodo de ZN
Kcr = 4.95;
Tcr = 0.9;
Kp  = 0.6*Kcr;
Ti = 0.5*Tcr;
Td = 0.125*Tcr;
g0 = Kp * (1 + (Td / Ts) + (Ts / Ti));
g1 = -Kp * (1 + 2 * (Td / Ts));
g2 = Kp * Td / Ts;
vmax = 100;


%% Simulação do sistema controlado
for i = 1:qntAmostras/3
 r(i) = 0.7 * vmax;
end
for i = (qntAmostras/3 + 1):(2*qntAmostras/3)
 r(i) = 0.2 * vmax;
end
for i = (2*qntAmostras/3 + 1):qntAmostras
 r(i) =  vmax;
end

for t = 4:qntAmostras
 y(t) = 0.8825*y(t-1) + 0.1316*u(t-3);
 e(t) = r(t) - y(t);
 u(t) = u(t-1) + g0 * e(t) + g1 * e(t-1) + g2 * e(t-2);
 if(u(t)>100) u(t) = 100; 
 end
 if(u(t)<0)   u(t) = 0;   
 end
 tempo(t) = t * Ts;
end

%% Gráfico do PID 

figure(2)
plot(tempo, r, tempo, y, 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Velocidade(RPS)');
legend(' Referencia ', ' Saida')
title('PID com controlador (2ZN)')
grid on
filepath = strcat(path_fig, '\PID com controlador (2ZN).png');
saveas(gcf, filepath);
%% Gráfico do sinal de controle
figure(3)
plot(tempo, u, 'g', 'LineWidth', 2);
title('Sinal de Controle (2ZN)')
xlabel('Tempo (s)');
ylabel('Velocidade(RPS)');
filepath = strcat(path_fig, '\Sinal de Controle (2ZN).png');
saveas(gcf, filepath);

%%  calculo da variança
soma_controle = 0;
media_controle = mean(u); % Calcula a média fora do loop para otimização

for t = 1:qntAmostras
 soma_controle = soma_controle + (u(t) - media_controle)^2;
end

variancia_controle = soma_controle / qntAmostras


soma_saida = 0;
media_y = mean(y); % Calcula a média fora do loop para otimização

for t = 1:qntAmostras
 soma_saida = soma_saida + (y(t) - media_y)^2;
end

variancia_saida = soma_saida / qntAmostras

%% Cálculo IAE
IAE = 0;
for t = 1:qntAmostras
    
    IAE = IAE+abs(r(t)-y(t));

end 

IAE 

saidas = [tempo' r' u' e' y']; 
path_data = 'C:\Users\franc\OneDrive\Documentos\Lab Controle Digital\2 pratica\outputs\2ZN.dat';
save('-ascii', path_data, 'saidas');
