function x = quat2rpy(h)

% Uso: x = quat2rpy(h)
%
% costruisce gli angoli RPY [teta_x teta_y teta_z] a partire dal
% corrispondente quaternione h 
% la formula utilizzata si trova in 
% "Standards for Representation in Autonomous Intelligent Systems" by DRDC
%
% gli angoli sono espressi in gradi
%
% B Bona, DAUIN, POLITO

qs=h(1);
qx=h(2);
qy=h(3);
qz=h(4);

x(3)=atan2((2*(qx*qy+qs*qz)),(2*(qs*qs+qx*qx)-1));

x(2)=asin(2*(qs*qy-qx*qz));

x(1)=atan2((2*(qy*qz+qs*qx)),(2*(qs*qs+qz*qz)-1));

x=rad2grad(x);

