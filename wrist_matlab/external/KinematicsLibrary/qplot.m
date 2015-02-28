%PLOT	plot a quaternion object as a rotated coordinate frame

%	Copright (C) Peter Corke 1999
function qplot(Q)
axis([-1 1 -1 1 -1 1])

R=quat2rot(Q);

x1 = R(:,1); 
y1 = R(:,2);
z1 = R(:,3);

hold on
plot3([0;1], [0;0], [0;0] ,'r')
plot3([0;0], [0;1], [0;0] ,'r')
plot3([0;0], [0;0], [0;1] ,'r')
text(1, 0, 0, 'x')
text(0, 1, 0, 'y')
text(0, 0, 1, 'z')

plot3([0; x1(1)], [0; x1(2)], [0; x1(3)])
text(x1(1), x1(2), x1(3), 'X')
plot3([0;y1(1)], [0; y1(2)], [0; y1(3)])
text(y1(1), y1(2), y1(3), 'Y')
plot3([0;z1(1)], [0; z1(2)], [0; z1(3)])
text(z1(1), z1(2), z1(3), 'Z')

grid on
xlabel('X')
ylabel('Y')
zlabel('Z')
hold off
