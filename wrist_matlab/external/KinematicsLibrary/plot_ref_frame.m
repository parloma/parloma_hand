function plot_ref_frame(Ref,OriginRef,colorCode,stemRatio,rhoRatio,axscale)

% plot_ref_frame plots a 3D representation of a reference frame 
% using three right orthogonal unit vectors 
% called x, y, z or red, green, blue
% 
% plot_ref_frame(Ref,OriginRef,colorCode,stemRatio,rhoRatio,axscale) 
%
%  Ref is a 3 x 3 orthogonal matrix representing the unit vectors
%      of the reference frame to be drawn
%
%  OriginRef is the reference frame origin point
%      default value = [0 0 0]'
%
%  colorcode is the code color of each axis
%      default value = ['r','g','b']
%
%  rhoRatio is the ratio of the cylinder radius
%      default value = 0.05
%
%  stemRatio is the ratio of the stem length wrt the arrowhead length
%      default value = 0.75
%
%  axscale is the common scale factor that multiplies the axes lenght
%      default value = 1.0
%
%	Copyright (C) Basilio Bona 2007, rev 2013

n=nargin;
if n == 1
    OriginRef=[0 0 0]';
    colorCode=[255/255 0 0 ;0 255/255 0; 0 0 255/255];
    stemRatio=0.75;
    rhoRatio=0.05;
    axscale=1.00;
end
if n == 2
    colorCode=[255/255 0 0 ;0 255/255 0; 0 0 255/255];
    stemRatio=0.75;
    rhoRatio=0.05;
    axscale=1.00;
 end    
if n == 3 
    stemRatio=0.75;
    rhoRatio=0.05;
    axscale=1.00;
end    
if n == 4 
    rhoRatio=0.05;
    axscale=1.00;
end    
if n == 5 
    axscale=1.00;
end    

arrow3d_new(OriginRef, axscale*Ref(:,1), colorCode(1,:), stemRatio, rhoRatio);
arrow3d_new(OriginRef, axscale*Ref(:,2), colorCode(2,:), stemRatio, rhoRatio);
arrow3d_new(OriginRef, axscale*Ref(:,3), colorCode(3,:), stemRatio, rhoRatio);

%     LIGHTING FLAT sets the lighting of the current graph to flat.
%     LIGHTING GOURAUD sets the lighting to gouraud.
%     LIGHTING PHONG sets the lighting to phong.

  lighting phong; 
  camlight headlight;

axis equal;   
xlabel('X'); ylabel('Y'); zlabel('Z');

