clc
clear 
close all
img1=imread('ParkingLot.jpg');
% img1= imrotate(img1,((-17)));
imshow(img1);
title('Original gray scale image')
 
%% Question 3.1
% grays=rgb2gray(img1);
% figure();
% imshow(img1)
% ALready a grayscale image

figure(1000)
histeq(img1) ;
%hist eq. gives a well distributed intensity image
title('Hist. equalization gray scale image')
% figure()
% for i=0.1:0.01:1;
% BW = im2bw(img1,i)
% print(i)
% imshow(BW)
% end
        % Select the threshold of the image using the loop
        %COnvert into Binary
figure()
BW=im2bw(img1,0.93);
BW=imfill(BW,'holes')
imshow(BW)
title('Binary image')

%%
% Question 3.2
% BW = edge(BW,'canny');
% figure();
% imshow(BW);


figure()
% [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
[H,T,R] = hough(BW,'RhoResolution',0.1,'Theta',-90:0.5:89);
subplot(2,1,1);
imshow(img1);
title('ParkingLot');
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of Parking Lot');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

[H,theta,rho] = hough(BW);
P = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','red');


lines = houghlines(BW,theta,rho,P,'FillGap',400,'MinLength',50);


figure, imshow(img1), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
   
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','black');
%% Question 3.4

label=bwlabel(BW)
max(max(label))
figure, imshow(img1), hold on
% kk=0

color = ['r','b','g','rb','r','b','g','rb','r','b','g','rb']

for k = 1:length(lines);
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color',color(k));
   z(k,:)=[lines(k).point1, lines(k).point2]
%    kk=kk+1

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','black');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy
      
%    else
%        [xi,yi] = polyxpoly(x1,y1,x2,y2)
%        
%        [xj,yj]= polyxpoly(x1,y1,x2,y2)
% 
   end

end
x1=[283;122;206;40;358;1;429]'
y1=[61;93;80;112;46;225;31]'
x2=[439;253;349;158;477;49;480]'
y2=[235;281;256;309;165;320;79]'
xint=[]
yint=[]
k=1
for i=1:length(x1)
    xint(k)=x1(i)
    yint(k)=y1(i)
    k=k+1
    xint(k)=x2(i)
    yint(k)=y2(i)
    k=k+1
end
x_long=[5;441;5;441;5;441;5;441;5;441;5;441;5;441]'
y_long=[237;128;237;128;237;128;237;128;237;128;237;128;237;128;]'

[xi,yi]=polyxpoly(x1,y1,x_long,y_long)
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','black');
z_long=[xy_long(1,:),xy_long(2,:)];





hold on;
X1 = [z(1,1),z(2,1),z(3,1),z(4,1),z(5,1),z(7,1),z(8,1)]
Y1 = [z(1,2),z(2,2),z(3,2),z(4,2),z(5,2),z(7,2),z(8,2)]
X2 = [z(1,3),z(2,3),z(3,3),z(4,3),z(5,3),z(7,3),z(8,3)]
Y2 = [z(1,4),z(2,4),z(3,4),z(4,4),z(5,4),z(7,4),z(8,4)]
Z1 = [z_long(1,1),z_long(1,3)]
Z2 = [z_long(1,2),z_long(1,4)]
clr = ['r','b','y','c','m','k']
interx=[]
intery=[]
for i =1:6
lx = [X1(i),X2(i)]
ly = [Y1(i),Y2(i)]
[XX(i),YY(i)] = polyxpoly(lx,ly,Z1,Z2)
interx(i)=XX(i)
intery(i)=YY(i)
plot(XX(i),YY(i),'x','LineWidth',2,'Color',color(i+1))
end

%saveas(jpg,'ParkingLot1.jpg')

X1=sort(X1);
Y1=sort(Y1);
Y1=flip(Y1);
X2=sort(X2);
Y2=sort(Y2);
Y2=flip(Y2);
interx=sort(interx);
intery=sort(intery);
intery=flip(intery);


position={[X1(1),Y1(1),interx(1),intery(1),interx(2),intery(2),X1(2),Y1(2)]}
polygon_image=insertShape(img1,'FilledPolygon',position,'LineWidth',2,'Color','r')
figure(), imshow(polygon_image), hold on

for i=2:length(X1)-2
position={[X1(i),Y1(i),interx(i),intery(i),interx(i+1),intery(i+1),X1(i+1),Y1(i+1)]}
 plot(X1(i),Y1(i),'x','LineWidth',2,'Color','yellow');
   plot(interx(i),intery(i),'x','LineWidth',2,'Color','black');
    plot(interx(i+1),intery(i+1),'x','LineWidth',2,'Color','yellow');
     plot(X1(i+1),Y1(i+1),'x','LineWidth',2,'Color','yellow');

polygon_image=insertShape(polygon_image,'FilledPolygon',position,'LineWidth',2,'Color','r')
imshow(polygon_image)
position={[X2(i),Y2(i),interx(i),intery(i),interx(i+1),intery(i+1),X2(i+1),Y2(i+1)]}

     plot(X2(i),Y2(i),'x','LineWidth',2,'Color','yellow');
   plot(interx(i),intery(i),'x','LineWidth',2,'Color','black');
    plot(interx(i+1),intery(i+1),'x','LineWidth',2,'Color','yellow');
     plot(X2(i+1),Y2(i+1),'x','LineWidth',2,'Color','yellow');

polygon_image=insertShape(polygon_image,'FilledPolygon',position,'LineWidth',2,'Color','g')
imshow(polygon_image)
  

end




