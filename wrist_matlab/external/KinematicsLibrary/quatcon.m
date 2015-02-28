function qc = quatcon(q)

% Uso: trasforma il quaternione q nel suo coniugato qc
%
% B Bona, DAUIN, POLITO

qc(:,1)=q(:,1); % BB parte reale al primo posto
qc(:,2)=-q(:,2);
qc(:,3)=-q(:,3);
qc(:,4)=-q(:,4);
