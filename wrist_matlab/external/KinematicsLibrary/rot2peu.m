function x = rot2peu (R)

% Uso:  s = rot2peu(R)
%
% Calcola i parametri di Eulero s a partire dalla matrice di rotazione R
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0
	x(4) = .5 * sqrt( 1 + R(1,1) + R(2,2) + R(3,3) );
	if x(4) < 1.0E-8
		% disp ('rotation = 180 degrees')
		x(1) = 1;
		x(2) = 0;
		x(3) = 0;
	elseif x(4) == 1
		% disp ('rotation = 0 degrees')
		x(1) = 0;
   	x(2) = 0;
   	x(3) = 0;
   else
		x(1) = (R(3,2) - R(2,3))/(4 * x(4));
		x(2) = (R(1,3) - R(3,1))/(4 * x(4));
		x(3) = (R(2,1) - R(1,2))/(4 * x(4));
	end
	x = x';
else
	disp ('Error in input matrix')
	x='ERROR';
end

