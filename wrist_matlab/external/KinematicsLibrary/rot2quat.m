function x = rot2quat (R)

% Uso:  Angles = rot2quat(R)
%
% Calcola il quaternione corrispondente a partire dalla matrice di rotazione R
%
% B Bona, DAUIN, POLITO

eps =  1.0e-7; % precisione con cui viene calcolato lo zero

if isrot(R) == 0
    s(4) = .5 * sqrt( 1 + R(1,1) + R(2,2) + R(3,3) );
   	if norm(s(4)) <= eps
		 disp ('rotation = 180 degrees')
		[u,teta]=rot2uth(R);
        s(1)=u(1);
        s(2)=u(2);
        s(3)=u(3);
	elseif norm(s(4)-1) <= eps
		 disp ('rotation = 0 degrees')
		s(1) = 0;
        s(2) = 0;
        s(3) = 0;
    else
        s(1) = (R(3,2) - R(2,3))/(4 * s(4));
        s(2) = (R(1,3) - R(3,1))/(4 * s(4));
        s(3) = (R(2,1) - R(1,2))/(4 * s(4));
    end
   	x(1) = s(4);
   	x(2) = s(1);
   	x(3) = s(2);
   	x(4) = s(3);
else
	disp ('Error in input matrix')
	x='ERROR';
end
