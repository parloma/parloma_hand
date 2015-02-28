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


function [ ] = plot_Plane( point, normal, x_range, y_range, fig_handler )
% Plot a plane defined by a Point and a normal vector

d = -dot(point,normal);

[xx,yy]=ndgrid(x_range,y_range);

%# calculate corresponding z
z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);

%# plot the surface
%figure;
surf(fig_handler,xx,yy,z);


end

