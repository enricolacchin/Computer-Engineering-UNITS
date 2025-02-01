% Tempo discreto
clear; clc;

% Segnale discreto
n = 0:15;                   % Campioni temporali
x = cos(2 * pi * 0.1 * n);  % Segnale: una sinusoide discreta

% Trasformata di Fourier discreta (DFT)
N = 256;                    % Numero di punti per la trasformata (zero-padding)
f = linspace(-pi, pi, N);   % Frequenza normalizzata [-pi, pi]
X_f = fftshift(fft(x, N));  % FFT con shift per frequenze centrate

% Antitrasformata di Fourier discreta
x_rec = ifft(ifftshift(X_f), N); % IFFT con shift inverso
x_rec = x_rec(1:length(n));      % Prendi solo i primi campioni dell'originale

% Visualizzazione
figure;

% Segnale nel dominio del tempo
subplot(3, 1, 1);
stem(n, x, 'b', 'LineWidth', 1.5);
title('Segnale discreto: x[n]');
xlabel('Campioni n');
ylabel('x[n]');
grid on;

% Trasformata di Fourier discreta
subplot(3, 1, 2);
plot(f, abs(X_f), 'r', 'LineWidth', 1.5);
title('Modulo della Trasformata di Fourier discreta: |X(e^{j\Omega})|');
xlabel('Frequenza normalizzata (\Omega)');
ylabel('|X(e^{j\Omega})|');
grid on;

% Segnale ricostruito
subplot(3, 1, 3);
stem(n, real(x_rec), 'g', 'LineWidth', 1.5); % Lunghezza corretta
title('Segnale ricostruito tramite Antitrasformata');
xlabel('Campioni n');
ylabel('x_{rec}[n]');
grid on;