% 1. Citește timestampul și rata de eșantionare din TEMP.csv
fileID = fopen('TEMP.csv', 'r');
start_line = fgetl(fileID);
sample_line = fgetl(fileID);
fclose(fileID);

start_unix = str2double(start_line);       % timestamp inițial
sample_rate = str2double(sample_line);     % Hz

% 2. Încarcă semnalul de temperatură
temp_values = readmatrix('TEMP.csv', 'NumHeaderLines', 2);
t = (0:length(temp_values)-1)' / sample_rate;  % vector timp relativ

% 3. Încarcă evenimentele din tags.csv
tags = readmatrix('tags.csv');
relative_tags = tags - start_unix;  % în secunde față de începutul TEMP

% 4. Reprezentare grafică temperatură + evenimente
figure;
plot(t, temp_values, 'b');
xlabel('Timp [s]');
ylabel('Temperatură [°C]');
title('Evoluția temperaturii cu marcaje din tags.csv');
grid on;
hold on;

% Marchează evenimentele
for i = 1:length(relative_tags)
    xline(relative_tags(i), 'r--', ['Eveniment ', num2str(i)], ...
        'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
end
hold off;
