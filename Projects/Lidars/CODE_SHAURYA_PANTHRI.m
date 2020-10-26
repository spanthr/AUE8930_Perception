clc;
clear all;
close all;

bin_files= dir('*.bin');    % Reading all the bin files
open1=fopen(bin_files(1).name);     % Opening the first file that is 002_00000000.bin
read1=fread(open1,'float32');                         % Reading the values of this file
c=1;
for i=1:4:length(read1);
    x(c)=read1(i);
    y(c)=read1(i+1);
    z(c)=read1(i+2);
    I(c)=read1(i+3);
    c=c+1;
end
% I=I'
figure()
pt=pointCloud([x(:),y(:),z(:)],'Intensity',I(:));     %  ,'Color',[0, 255]
pcshow(pt)
% plot3(x,y,z,'.');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Point cloud of frame colored with its refelctivity value')

%% Question 02

% pt_down=pcdownsample(pt,'random',.50)      % pecentage
% pt_down = pcdownsample(pt,'gridAverage',10)  % GRid Step (Uniform Grid Average) downsampled point cloud using a box grid filter. The gridStep input specifies the size of a 3-D box.
 pt_down = pcdownsample(pt,'nonuniformGridSample',7);     %nonuniform box grid filt
figure()
pcshow(pt_down)

title("downsampled with box grid filter")
xlabel('X');
ylabel('Y');
zlabel('Z');

%% Question 03


%[model,inlierIdx] = ransac(data,fitFcn,distFcn,sampleSize,maxDistance)
% [model,inlierIdx] = ransac(data,fitFcn,distFcn,sampleSize,maxDistance)
maxDistance=0.5;   

vectorr= [0,0,1];
maxAngularDistance = 3;
tic
[model,inlierIndices,outlierIndices,meanError] = pcfitplane(pt_down,maxDistance,vectorr,maxAngularDistance);
elapsed_time =toc

display("The time elapsed to run this algorithm is:" + elapsed_time)
% figure()
%  model.plot;
% title("Ground Plane using MSAC")
% xlabel('X');
% ylabel('Y');
% zlabel('Z');

display(model.Parameters)
% display(model.Values)

hold off
figure()
pcshow(pt_down)
hold on;
 model.plot;
 title("Visualizing the Ground Plane along with all the points in 3D using MSAC ")
xlabel('X');
ylabel('Y');
zlabel('Z');
hold off;

% Plot the off Ground indices

offgroundplane = select(pt_down,outlierIndices);
figure()
pcshow(offgroundplane)
 title("Visualizing all the off Ground Points")
xlabel('X');
ylabel('Y');
zlabel('Z');

% Plot the on Ground indices 
figure()
ongroundplane = select(pt_down,inlierIndices);
pcshow(ongroundplane)
 title("Visualizing all the on Ground Planes")
xlabel('X');
ylabel('Y');
zlabel('Z');

%% Question 04
offground=pt_down.Location(outlierIndices,:,:);
% offground=pt_down.Intensity()
 offground(:,3)=0;
 Intense=pt_down.Intensity(outlierIndices(:,1));
 pt_ground=pointCloud([offground(:,1),offground(:,2),offground(:,3)],'Intensity',Intense(:));
 % A point cloud object for the projection of off-ground points
figure();
pcshow(pt_ground)
 title("x-y projection to the off-ground points ")
xlabel('X');
ylabel('Y');
zlabel('Z');
% view(0,90)

offground=offground(:,1:2);
figure()
scatter(offground(:,1),offground(:,2),0.11)
title("x-y projection to the off-ground points ")
xlabel('X');
ylabel('Y');


%% QUestion 05
%% cartesian to polar

% [theta(:),rho(:),z1(:)] = cart2pol(x(:),y(:),z(:));

[theta1(:),phi(:),rhoo1(:)] = cart2sph(x(:),y(:),z(:));
% [theta1,phi]=meshgrid(theta1,phi);
figure()
axis equal
% p_cloud=pointCloud([theta1(:),rhoo1(:),phi(:)],'Intensity',I(:))
%  pcshow(p_cloud)
% scatter3(theta1,phi,rhoo1,'.');
[x,y,z]=sph2cart(theta1,phi,rhoo1);
plot3(x,y,z,'.','color',0.2*[0 1 0]);
figure()
hold on;
R=max(rhoo1);
latspacing = 10; 
lonspacing = 10; 
% lines of longitude: 
[lon1,lat1] = meshgrid(0:10:360,linspace(-90,90,300)); 
[x1,y1,z1] = sph2cart(lon1*pi/180,lat1*pi/180,R); 
plot3(x1,y1,z1,'-','color',0.2*[1 1 1])

hold on
% lines of latitude: 
[lat2,lon2] = meshgrid(0:10:360,linspace(-180,180,300)); 
[x2,y2,z2] = sph2cart(lon2*pi/180,lat2*pi/180,R); 
plot3(x2,y2,z2,'-','color',0.5*[1 1 1])
hold on;
pt1=pointCloud([x(:),y(:),z(:)],'Intensity',I(:));
pcshow(pt1)
title("visualize all the point cloud in spherical Coordinate")
axis equal tight off

%% Question 05 part 02 (Depth image)

figure();
pt=pointCloud([x(:),y(:),z(:)],'Intensity',z(:));     %  ,'Color',[0, 255]
pcshow(pt);
colorbar();
colorbar('AxisLocation','in');
view(90,0);
title('2D depth image');

figure()
pt=pointCloud([x(:),y(:),z(:)],'Intensity',z(:));     %  ,'Color',[0, 255]
pcshow(pt);
colorbar('AxisLocation','in')
view(0,90);
title('2D depth image');


