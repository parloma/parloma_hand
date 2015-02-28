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

%% TEST CIRCLE CURVE

clc
clear all
close all

locus_of_desired_pose = zeros(3,1);

Rtest = 6;

P4 = [0;0;36.57];

centerTest = P4 + [0;0;10];

i=1;
for t=0:pi/30:2*pi

%TEST CIRCLE PARAMETRIC EQUATION:
locus_of_desired_pose(:,i) = centerTest + Rtest*cos(t)*[1;0;0] + Rtest*sin(t)*[0;1;0];


i=i+1;
end

[q1alto, q1medio, q1basso]=IKPenguinWrist(locus_of_desired_pose);