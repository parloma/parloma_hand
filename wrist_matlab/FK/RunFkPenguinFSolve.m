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


%% RUN the FK with fsolve...numerical solver!!
clc
clear all
close all
%% Actuated Joints values
q1alto = deg2rad(19.0073);
q1medio = deg2rad(-165.1570);
q1basso = deg2rad(139.9911);

%% Real solution defined by IK (To compute the error)
roll =pi/3;%pi/6; 
pitch=pi/5; %-pi/5;
yaw = pi/6;%pi/7;

%% Initial Guess
RPY0 = [deg2rad(0),deg2rad(0),deg2rad(0)];

[RPY,fval] = FKPenguinEquations(RPY0,q1alto,q1medio,q1basso);

RPYdeg = rad2deg(RPY)

errorInRad = [ roll - RPY(1); pitch-RPY(2); yaw-RPY(3) ];

errorInDeg = rad2deg(errorInRad)