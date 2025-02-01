% Tempo continuo
clear; clc;

% Passo temporale e asse temporale
dt = 0.01;                  % Passo temporale
t = -10:dt:10;              % Asse temporale

% Segnale nel dominio del tempo (es. impulso rettangolare)
x = (t >= -1 & t <= 1);     % Impulso rettangolare tra -1 e 1

% Trasformata di Fourier
f = -10:0.01:10;            % Asse delle frequenze
X_f = zeros(size(f));       % Inizializzazione della trasformata

for k = 1:length(f)
    X_f(k) = sum(x .* exp(-1j * 2 * pi * f(k) * t)) * dt; % Integrale numerico
end

% Antitrasformata di Fourier
x_rec = zeros(size(t));     % Inizializzazione del segnale ricostruito
for k = 1:length(t)
    x_rec(k) = sum(X_f .* exp(1j * 2 * pi * f * t(k))) * (f(2) - f(1));
end

% Visualizzazione
figure;

% Segnale nel dominio del tempo
subplot(3, 1, 1);
plot(t, x, 'b', 'LineWidth', 1.5);
title('Segnale nel dominio del tempo: x(t)');
xlabel('Tempo (s)');
ylabel('x(t)');
grid on;

% Trasformata di Fourier
subplot(3, 1, 2);
plot(f, abs(X_f), 'r', 'LineWidth', 1.5);
title('Modulo della Trasformata di Fourier: |X(f)|');
xlabel('Frequenza (Hz)');
ylabel('|X(f)|');
grid on;

% Segnale ricostruito
subplot(3, 1, 3);
plot(t, real(x_rec), 'g', 'LineWidth', 1.5);
title('Segnale ricostruito tramite Antitrasformata');
xlabel('Tempo (s)');
ylabel('x_{rec}(t)');
grid on;