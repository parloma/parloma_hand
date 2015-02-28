function R = eul2rot (Angles)

% Uso:  R = eul2rot(Angles)
%
% Calcola la matrice di rotazione R 
% a partire dagli angoli di eulero espressi in gradi
% Angles(1) = Fi, Angles(2) = Teta, Angles(3) = Psi
%
% B Bona, DAUIN, POLITO


F  = Angles(1);
T  = Angles(2);
P  = Angles(3);

cf = cosd(F);
ct = cosd(T);
cp = cosd(P);

sf = sind(F);
st = sind(T);
sp = sind(P);

R(3,3) =  ct;
R(1,1) =  cf * cp - sf * ct * sp;     
R(1,2) = -cf * sp - sf * ct * cp;
R(1,3) =  sf * st;
R(2,1) =  sf * cp + cf * ct * sp;
R(2,2) = -sf * sp + cf * ct * cp;
R(2,3) = -cf * st;
R(3,1) =  st * sp;
R(3,2) =  st * cp;