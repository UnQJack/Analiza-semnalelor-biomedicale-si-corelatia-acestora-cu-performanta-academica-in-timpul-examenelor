% 1. Citește timestampul și rata de eșantionare din BVP.csv
fileID = fopen('BVP.csv', 'r');
start_time_line = fgetl(fileID);
sample_rate_line = fgetl(fileID);
fclose(fileID);

start_time = str2double(start_time_line);
sample_rate = str2double(sample_rate_line);

% 2. Încarcă semnalul BVP
bvp_values = readmatrix('BVP.csv', 'NumHeaderLines', 2);  % sar primele 2 linii

% Vectorul de timp
t = (0:length(bvp_values)-1)' / sample_rate;

% 3. Construiește matricea de ferestre pentru PCA
window_size = 128;
step = 16;

num_windows = floor((length(bvp_values) - window_size) / step);
X = zeros(num_windows, window_size);

for i = 1:num_windows
    idx = (i-1)*step + 1;
    X(i,:) = bvp_values(idx : idx + window_size - 1)';
end

% 4. PCA (manual, fără toolbox)
X_centered = X - mean(X);
C = cov(X_centered);
[V, D] = eig(C);
[latent, idx] = sort(diag(D), 'descend');
V = V(:, idx);
score = X_centered * V;
explained = 100 * latent / sum(latent);

% Timp asociat fiecărei ferestre
t_windows = ((0:num_windows-1) * step + window_size/2) / sample_rate;

% 5. Citește evenimentele din tags.csv
tags = readmatrix('tags.csv');
relative_event_times = tags - start_time;  % timp relativ față de începutul BVP

% 6. Grafic PCA + marcaje
figure;
plot(t_windows, score(:,1:2));
xlabel('Timp [s]');
ylabel('Componentă principală');
legend('PC1', 'PC2');
title('PCA pe semnalul BVP cu marcaje din tags.csv');
grid on;
hold on;

% Adaugă liniile verticale roșii
for i = 1:length(relative_event_times)
    xline(relative_event_times(i), 'r--', ['Eveniment ', num2str(i)], ...
        'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
end
hold off;

% 7. Afișare varianță explicată
disp('Varianță explicată de componentele principale:');
disp(explained);
