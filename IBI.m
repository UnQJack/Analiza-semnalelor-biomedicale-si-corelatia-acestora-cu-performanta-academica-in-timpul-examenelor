% 1. Încarcă datele IBI (timp și durată între bătăi)
ibi_data = readmatrix('IBI.csv');
ibi_time = ibi_data(:,1);       % momentele pulsului [s]
ibi_values = ibi_data(:,2);     % durata dintre bătăi [s]

% 2. Încarcă tags.csv și calculează timpul relativ
fileID = fopen('HR.csv', 'r');  % folosim HR.csv doar pentru a obține start_time
start_line = fgetl(fileID);
fclose(fileID);
start_unix = str2double(start_line);

tags = readmatrix('tags.csv');
relative_tags = tags - start_unix;  % în secunde

% 3. Reprezentare grafică a IBI-urilor în timp + evenimente
figure;
plot(ibi_time, ibi_values, 'b');
xlabel('Timp [s]');
ylabel('Interval între bătăi (IBI) [s]');
title('Evoluția ritmului cardiac (IBI) cu marcaje din tags.csv');
grid on;
hold on;

for i = 1:length(relative_tags)
    xline(relative_tags(i), 'r--', ['Eveniment ', num2str(i)], ...
        'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
end
hold off;
