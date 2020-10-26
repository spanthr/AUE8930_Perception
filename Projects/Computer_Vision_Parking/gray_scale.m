function [gray] = gray_scale(gray)
r= gray(:,:,1);
g= gray(:,:,2);
b= gray(:,:,3);
gray = 0.2989 * r + 0.5870 * g + 0.1140 * b
% gray = 0 * r + 0 * g + 0 * b
