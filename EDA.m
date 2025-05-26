% 1. Citește timestampul și rata de eșantionare din EDA.csv
fileID = fopen('EDA.csv', 'r');
start_line = fgetl(fileID);
sample_line = fgetl(fileID);
fclose(fileID);

start_time = str2double(start_line);
sample_rate = str2double(sample_line);

% 2. Încarcă semnalul EDA
eda_values = readmatrix('EDA.csv', 'NumHeaderLines', 2);
t = (0:length(eda_values)-1)' / sample_rate;

% 3. Construiește matricea de ferestre (sliding window)
window_size = 128;   % lungimea ferestrei
step = 16;           % pasul ferestrei

num_windows = floor((length(eda_values) - window_size) / step);
X = zeros(num_windows, window_size);

for i = 1:num_windows
    idx = (i-1)*step + 1;
    X(i,:) = eda_values(idx : idx + window_size - 1)';
end

% 4. Aplică PCA (manual, fără toolbox)
X_centered = X - mean(X);
C = cov(X_centered);
[V, D] = eig(C);
[latent, idx] = sort(diag(D), 'descend');
V = V(:, idx);
score = X_centered * V;
explained = 100 * latent / sum(latent);

% Vector de timp asociat fiecărei ferestre
t_windows = ((0:num_windows-1) * step + window_size/2) / sample_rate;

% 5. Încarcă evenimentele din tags.csv
tags = readmatrix('tags.csv');
relative_tags = tags - start_time;

% 6. Plot PCA + marcaje
figure;
plot(t_windows, score(:,1:2));
xlabel('Timp [s]');
ylabel('Componentă principală');
legend('PC1', 'PC2');
title('PCA pe semnalul EDA cu marcaje din tags.csv');
grid on;
hold on;

for i = 1:length(relative_tags)
    xline(relative_tags(i), 'r--', ['Eveniment ', num2str(i)], ...
        'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
end
hold off;

% 7. Afișează varianța explicată
disp('Varianță explicată de componentele principale:');
disp(explained);
