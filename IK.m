% syms  Ox Oy Oz 
% syms Ax Ay Az X5 Y5 Z5
% 

%desire point
Nx=T06(1,1);
Ny=T06(2,1);
Nz=T06(3,1);

Ox=T06(1,2);
Oy=T06(2,2);
Oz=T06(3,2);

Ax=T06(1,3);
Ay=T06(2,3);
Az=T06(3,3);

X5=T06(1,4);
Y5=T06(2,4);
Z5=T06(3,4);

P5 = [Nx Ox Ax X5;Ny Oy Ay Y5; Nz Oz Az Z5; 0 0 0 1];

% NOTE: this will assume the axis is on the right side of the plane
%direct calculate theta1
theta1 = atan2d(Y5,X5)

%put the P5 direction in the polar coordinates(in the plane)
Ar = sqrt(Ax^2+Ay^2);

signX = (Ax/abs(Ax)); %we are assuming the AxAyAz is on the plane
if isnan(signX)
    signX=1;
end

% z axis angle in the plane
% thus is the robot end pointing angle phi
phi = atan2d(Az,Ar*signX);

% transform the end position to polar plane
R5 = sqrt(X5^2+Y5^2);
% thus the position is (R5,Z5)

% the length of last joint
l3 = 10;

% on the direction of the last joint
% push back 10cm to get the joint4 position
R4 = R5-(l3*cosd(phi))
Z4 = Z5-(l3*sind(phi))
% thus it become a two-DoF problem..

l1 = 44;
l2 = 55;

px = R4;
py = Z4 - 11; % get rid of the base height

%% %%%%%%%%%%%% Inverse Kinematics of a 2DOF manipulator %%%%%%%%%%%%%%%%%

%% Find q2
c2 = (px^2+py^2-l1^2-l2^2)/(2*l1*l2) ;
s21 = sqrt(1-c2^2) ;
s22 = - sqrt(1-c2^2) ;
% We have two solutions for q2
q21 = atan2(s21,c2) ;
q22 = atan2(s22,c2) ;


%% Find q1

% We define the constants
k1 = l1+l2*c2 ;
k21 = l2*s21 ;
k22 = l2*s22 ;
gama1 = atan2(k21,k1) ;
gama2 = atan2(k22,k1) ;
r = sqrt(k1^2+k21^2) ; % r is the same for both values of q2

% We find q1 depending on the value of q2
q11 = atan2(py/r,px/r) - gama1 ;
q12 = atan2(py/r,px/r) - gama2 ;


disp('1 solution')
disp([ q11 q21 ]*180/pi)

disp('1 solution')
disp([ q12 q22 ]*180/pi)
