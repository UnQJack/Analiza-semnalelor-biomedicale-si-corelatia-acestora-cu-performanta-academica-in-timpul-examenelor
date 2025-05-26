% 1. Citește timestampul și rata de eșantionare din HR.csv
fileID = fopen('HR.csv', 'r');
start_line = fgetl(fileID);
sample_line = fgetl(fileID);
fclose(fileID);

start_unix = str2double(start_line);     % timestamp inițial
sample_rate = str2double(sample_line);   % Hz

% 2. Încarcă semnalul de ritm cardiac
hr_values = readmatrix('HR.csv', 'NumHeaderLines', 2);  % linia 3 în jos
t = (0:length(hr_values)-1)' / sample_rate;             % timp relativ

% 3. Încarcă evenimentele din tags.csv
tags = readmatrix('tags.csv');
relative_tags = tags - start_unix;  % în secunde de la începutul sesiunii

% 4. Reprezentare grafică HR + marcaje
figure;
plot(t, hr_values, 'b');
xlabel('Timp [s]');
ylabel('Ritm cardiac [BPM]');
title('Ritm cardiac mediu (HR) în funcție de timp cu marcaje evenimente');
grid on;
hold on;

for i = 1:length(relative_tags)
    xline(relative_tags(i), 'r--', ['Eveniment ', num2str(i)], ...
        'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
end

hold off;
