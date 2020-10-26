

% [counts,grayLevels]=Histogramz(gray1)      % Computes the histogram analysis of the image
function [counts, grayLevel] = Histogramz(gray1)
[rows, columns] = size(gray1);
counts = zeros(1, length(gray1));
for col = 1 : columns
  for row = 1 : rows
    grayLevel = gray1(row, col);           % Get the gray level.
    counts(grayLevel+1) = counts(grayLevel+1) + 1;   % Add 1 because graylevel zero goes into index 1 and so on.
  end
end
% Plot the histogram.
intensity_levels = 0 : 255;
figure();
bar(intensity_levels, counts, 'BarWidth', 0.5, 'FaceColor', 'r');
xlabel('intensity Levels');
ylabel('Pixel Count');
title('Histogram analysis of LennaGray.jpg');
grid on;
end

