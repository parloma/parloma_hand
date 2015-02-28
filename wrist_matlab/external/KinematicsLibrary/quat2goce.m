function qg = quat2goce(q)
% 
% trasforma i quaternioni alla BB in quaternioni alla GOCE
%
qg(:,1)=q(:,2); % BB parte reale al primo posto
qg(:,2)=q(:,3);
qg(:,3)=q(:,4);
qg(:,4)=q(:,1);
