% 1. Citește informațiile din ACC.csv
fileID = fopen('ACC.csv', 'r');
start_line = fgetl(fileID);
sample_line = fgetl(fileID);
fclose(fileID);

start_vals = str2double(strsplit(start_line, ','));
sample_vals = str2double(strsplit(sample_line, ','));

start_unix = start_vals(1);      % timestamp inițial în secunde
sample_rate = sample_vals(1);    % rată de eșantionare în Hz

% 2. Încarcă datele accelerometrului (X, Y, Z)
acc_data = readmatrix('ACC.csv', 'NumHeaderLines', 2);  % sar primele 2 linii
acc = acc_data / 64;  % conversie la g

% Vectorul de timp în secunde
t = (0:size(acc,1)-1)' / sample_rate;

% 3. Generează multiple evenimente (stres/relaxare)
offsets_sec = [300, 1200, 1500, 1800];  % în secunde (minute 5, 20, 25, 30)
event_timestamps = start_unix + offsets_sec;

% Salvează în tags.csv (fără antet)
writematrix(event_timestamps', 'tags.csv');

% 4. Citește tags.csv și calculează momentele relative
tags = readmatrix('tags.csv');
relative_tags = tags - start_unix;  % în secunde

% 5. PCA fără toolbox (manual)
acc_centered = acc - mean(acc);    % centrare
C = cov(acc_centered);            % matricea de covarianță
[V, D] = eig(C);                  % vectori și valori proprii
[latent, idx] = sort(diag(D), 'descend');  % sortare valori proprii
coeff = V(:, idx);               % vectorii proprii ordonați
score = acc_centered * coeff;    % proiecția în spațiul PCA
explained = 100 * latent / sum(latent);  % varianță explicată în procente

% 6. Reprezentare grafică PCA cu marcaje multiple
figure;
plot(t, score(:,1:2));
xlabel('Timp [s]');
ylabel('Componentă principală');
legend('PC1', 'PC2');
title('PCA pe datele ACC (fără toolbox) cu evenimente multiple');
grid on;
hold on;

for i = 1:length(relative_tags)
    xline(relative_tags(i), 'r--', ['Eveniment ', num2str(i)], 'LabelOrientation', 'horizontal');
end
hold off;

% 7. Afișează varianța explicată
disp('Varianță explicată de componentele principale:');
disp(explained);
