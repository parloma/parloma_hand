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

%% F(q1,RPY_(1),RPY_(2),RPY_(3)) == 0

% Use nested function to pass parameters q1 to the FK equations system

function [x,fval] = FKPenguinEquations(RPY0,q1alto,q1medio,q1basso)

    options = optimoptions('fsolve','Display','iter'); % Option to display output
    [x,fval] = fsolve(@FKPenguinEqns,RPY0,options); % Call solver

    function f = FKPenguinEqns(RPY_)
        
        f = [ (cos(RPY_(2))*sin(RPY_(1)))/2 + (3^(1/2)*cos(q1alto)*(cos(RPY_(1))*sin(RPY_(3)) - cos(RPY_(3))*sin(RPY_(2))*sin(RPY_(1))))/2 - (3^(1/2)*sin(q1alto)*(cos(RPY_(1))*cos(RPY_(3)) + sin(RPY_(2))*sin(RPY_(1))*sin(RPY_(3))))/2;...
              (3^(1/2)*sin(q1medio)*((cos(RPY_(1))*cos(RPY_(3)))/2 + (sin(RPY_(2))*sin(RPY_(1))*sin(RPY_(3)))/2 - (3^(1/2)*cos(RPY_(2))*sin(RPY_(3)))/2))/2 - (3^(1/2)*sin(RPY_(2)))/4 - (3^(1/2)*cos(q1medio)*((cos(RPY_(1))*sin(RPY_(3)))/2 - (cos(RPY_(3))*sin(RPY_(2))*sin(RPY_(1)))/2 + (3^(1/2)*cos(RPY_(2))*cos(RPY_(3)))/2))/2 - (cos(RPY_(2))*sin(RPY_(1)))/4;...
              (3^(1/2)*sin(RPY_(2)))/4 - (cos(RPY_(2))*sin(RPY_(1)))/4 + (3^(1/2)*cos(q1basso)*((cos(RPY_(3))*sin(RPY_(2))*sin(RPY_(1)))/2 - (cos(RPY_(1))*sin(RPY_(3)))/2 + (3^(1/2)*cos(RPY_(2))*cos(RPY_(3)))/2))/2 + (3^(1/2)*sin(q1basso)*((cos(RPY_(1))*cos(RPY_(3)))/2 + (sin(RPY_(2))*sin(RPY_(1))*sin(RPY_(3)))/2 + (3^(1/2)*cos(RPY_(2))*sin(RPY_(3)))/2))/2
            ];
        
    end
end
 