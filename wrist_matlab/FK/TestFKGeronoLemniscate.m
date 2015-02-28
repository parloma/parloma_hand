%% Copyright (C) 2015 Politecnico di Torino
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
% Contributors:
%   Giorgio Toscana (giorgio.toscana@polito.it)

%% Test the FK numerical solver error during the execution of a specific path

%% RUN the FK with fsolve...numerical solver!!
clc
clear all
close all
%% Actuated Joints values And Eight Curve Path

locus_of_desired_pose = zeros(3,1);

Rtest = 6;

P4 = [0;0;36.57];

z_comp_of_path = 10;

centerTest = P4 + [0;0;z_comp_of_path];

i=1;
for t=0:pi/30:2*pi

%TEST Eight CURVE PARAMETRIC EQUATION:

locus_of_desired_pose(1,i) = Rtest*sin(t);
locus_of_desired_pose(2,i) = Rtest*sin(t)*cos(t);
locus_of_desired_pose(3,i) = centerTest(3);

i=i+1;
end
%qi and RPY_ in degrees
[q1alto, q1medio, q1basso, RPY_locus_path]=IKPenguinWristwithRPYoutput(locus_of_desired_pose);

%% Solution for each point in the Path
for n_path=1:1:length(q1alto)

    %% Initial Guess
    RPY0 = [deg2rad(0),deg2rad(0),deg2rad(0)];

    %% Solutions, RPY in rad
    [RPY,fval] = FKPenguinEquations(RPY0,deg2rad(q1alto(n_path)),deg2rad(q1medio(n_path)),deg2rad(q1basso(n_path)));
    
    RPYdeg = rad2deg(RPY);

    errorInRad(:,n_path) = [ deg2rad(RPY_locus_path(1,n_path)) - RPY(1);...
                             deg2rad(RPY_locus_path(2,n_path)) - RPY(2);...
                             deg2rad(RPY_locus_path(3,n_path)) - RPY(3)];

    errorInDeg = rad2deg(errorInRad);
    
end

  figure;
  
  plot(1:1:length(q1alto),errorInDeg(1,:),'r');
  hold on;
  plot(1:1:length(q1alto),errorInDeg(2,:),'g');
  plot(1:1:length(q1alto),errorInDeg(3,:),'b');
  title('Gerono Lemniscate (Eight Curve): numerical solution FK error');
  ylabel('error [DEGREES]');
  xlabel('i_{th} point in the path')
  legend('roll','pitch','yaw');
  grid on;
% figure;
% plot(path_error(1,:),path_error(2,:),'k');

