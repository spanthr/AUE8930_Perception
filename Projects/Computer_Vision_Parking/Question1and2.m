clc
clear 
close all
%% Question 01.01
img=imread('Lenna.jpg');
imshow(img)
gray1=gray_scale(img)
figure()
imshow(gray1)




%% QUESTION 1.2  Down sampled
resampled=gray1(1:2:length(gray1),1:2:length(gray1))
resampled=resampled(1:2:length(resampled),1:2:length(resampled))
figure()
imshow(resampled)                           % Down sampled image 

l=length(gray1)/2
arr=down_sample(gray1)
l=l/2

%% Question 01.03 Edge detection using SOBEL
maskx=[-1 -2 -1;
        0 0 0;
        1 2 1];             % go to the image and multiply with mask and keep shifting and save the result.

grayc=double(gray1)
[row,column]=size(gray1)  % store the rows and columns of the GrayLenna image.
conv=zeros(row-3,column-3);
for i=1:(row-3);
    for j=1:(column-3);                 % last index is row and column minus 3 because the length of the map is 3x3
%         cla
%         imshow(gray1)
%         rectangle('Position',[i j 3 3])       % Visualize the movement of the kernel
%         drawnow
        gray_extract= grayc(i:(i+2),j:(j+2));
        r=maskx.*gray_extract;
        conv(i,j)=sum(sum(r));
    end
end
Gx= conv;
figure()
imshow(Gx)
title("Sobel in X direction")


% MASK in Y direction
masky=[-1 0 1;
        -2 0 2;
        -1 0 1];
conv=zeros(row-3,column-3);
for i=1:(row-3);
    for j=1:(column-3);                 % last index is row and column minus 3 because the length of the map is 3x3
%         cla
%         imshow(gray1)
%         rectangle('Position',[i j 3 3])       % Visualize the movement of the kernel
%         drawnow
        gray_extract1= grayc(i:(i+2),j:(j+2));
        r1=masky.*gray_extract1;
        conv(i,j)=sum(sum(r1));
    end
end
Gy= conv;
figure()
imshow((Gy))
title("Sobel in Y direction")

% Resultant of Gx and Gx for normalizing
G=uint8(sqrt((Gx.^2) +(Gy.^2)));
figure()
imshow(G)
title('Edge Detection of LennaGray using Sobel')



%% Question 02 Histogram Analysis of LennaGray.jpg
%% Question 2.1 and 2.2

[counts,grayLevel]=Histogramz(gray1)      % Computes the histogram analysis of the image % counts corresponds freq
  % gray levels is intensity of the 256x256 pixel for  debugging
                                       
%Comparison using imhist() function of matlab
% figure();
% imhist(gray1);
% title('Histogram using matlab')

%% Question 2.2
cf=zeros(1,length(counts));
pdf=zeros(1,length(counts));
size=size(gray1);
pixel_total=size(1)*size(2);
pdf(1)=counts(1)/pixel_total;
cdf(1)=pdf(1);
for i=2:length(counts);
    pdf(i)=counts(i)/pixel_total;
    cf(i)=pdf(i-1)+cf(i-1);
end
figure();
intensity_levels = 0 : 255;
bar(intensity_levels,cf,'Barwidth',0.5,'FaceColor','b');
xlabel('Intensity Level');
ylabel('Cumulative Frequency');
title('Cumulative Histogram Distribution');
grid on;

%% Question 2.3
func=uint8(zeros(1,length(counts)));
l1=length(counts)
for i=1:l1;
    func(i)=uint8(255* cf(i));
         % sampling can also use round()
end
% figure();
% bar(intensity_levels,func,'Barwidth',0.5,'FaceColor','b');
% xlabel('Intensity Level');
% ylabel('Cumulative Frequency');
% title('CF');
% grid on;


for i=1:row;
for j=1:column;
 gray2(i,j)=func(gray1(i,j)+1);
end
end
figure()
bar(intensity_levels,gray2,'Barwidth',0.5,'FaceColor','b');
title('Hitogram equalization')

figure,imshow(gray2);
title('Histogram equailization')


% figure()
% a=histeq(gray1)           %Using built in function
% bar(intensity_levels,a,'Barwidth',0.5,'FaceColor','b');
% title('HIstogram equlization using matlab function')
