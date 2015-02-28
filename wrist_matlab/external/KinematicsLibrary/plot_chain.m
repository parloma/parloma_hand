function plot_chain(Vertices,Ivertices,colorCode,rhoRatio,axscale)

% plot_chain plots a 3D representation of the robot kinematic chain 
% as a set of ncV segments given by ncV+1 (x,y,z) coordinates 
% stored in Vertices(1:3,1:ncV)
% each segment starts where the previous ends
% all segments have the same color given by colorCode
% 
% plot_segment(Vertices,colorCode,rhoRatio,axscale) 
%
%   Vertices is a 3 X Ns matrix representing the extremal points of a
%   segment be drawn
%
%   Ivertices (1:ncV)    if == 1 plot the ball 
%                        if == 0 do not plot the ball
%   colorcode is the code color of each segment
%      default value = 'b'
%
%   rhoRatio is the ratio of the cylinder radius representing a segment
%      default value = 0.05
%
%   axscale is the common scale factor that multiplies the axes lenght
%      default value = 1.0
%
%	Copyright (C) Basilio Bona 2007, rev 2013

n=nargin;
[nrV,ncV]=size(Vertices);

if n == 1
%     colorCode=[0 0 255/255];  % blue
    colorCode=[159/255 182/255 205/255]; % light gray
    Ivertices=zeros(1,ncV);
%     colorCode=[0.4 0.4 0.4]; % dark gray
    rhoRatio=0.05;
    axscale=1.00;
end
if n == 2
%     colorCode=[0 0 255/255];  % blue
    colorCode=[159/255 182/255 205/255]; % light gray
    rhoRatio=0.05;
    axscale=1.00;
end    
if n == 3
    rhoRatio=0.05;
    axscale=1.00;
end    
if n == 4
    axscale=1.00;
end    

xx=Vertices(1,:);
yy=Vertices(2,:);
zz=Vertices(3,:);

plot3(xx(1:ncV),yy(1:ncV),zz(1:ncV),'-k','Color',colorCode,'LineWidth',4);
for k=1:ncV
    if Ivertices(k)==1
        plot3(xx(1,k),yy(1,k),zz(1,k),'ok','Color',colorCode,'LineWidth',4);
    end
end

%     LIGHTING FLAT sets the lighting of the current graph to flat.
%     LIGHTING GOURAUD sets the lighting to gouraud.
%     LIGHTING PHONG sets the lighting to phong.

  lighting phong; 
  camlight headlight;

axis equal;   
xlabel('X'); ylabel('Y'); zlabel('Z');

