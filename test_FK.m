% syms s1 c1 s2 c2 s3 c3 s4 c4 s5 c5
% syms theta1 theta2 theta3 theta4 theta5

theta1 = 0;
theta2 = 90;
theta3 = -90;
theta4 = 0;
theta5 = 0;

s1 = sind(theta1);
c1 = cosd(theta1);

s2 = sind(theta2);
c2 = cosd(theta2);

s3 = sind(theta3);
c3 = cosd(theta3);

s4 = sind(theta4);
c4 = cosd(theta4);

s5 = sind(theta5);
c5 = cosd(theta5);

A1 = [c1 -s1  0  0;
      s1  c1  0  0;
      0   0   1  0;
      0   0   0  1];
A2 = [c2 -s2  0  0;
      0   0  -1  0;
      s2  c2  0  11;
      0   0   0  1];
A3 = [c3 -s3  0  44;
      s3  c3  0  0;
      0   0   1  0;
      0   0   0  1];
A4 = [c4 -s4  0  55;
      s4  c4  0  0;
      0   0   1  0;
      0   0   0  1];
A5 = [0  -1   0  10;
      1   0   0  0;
      0   0   1  0;
      0   0   0  1];
A6 = [c5 -s5  0  0;
      0   0  -1  0;
      s5  c5  0  0;
      0   0   0  1];

format bank
T0 = eye(4,4);
T01 = A1;
T02 = A1*A2;
T03 = A1*A2*A3;
T04 = A1*A2*A3*A4;
T05 = A1*A2*A3*A4*A5;
T06 = A1*A2*A3*A4*A5*A6;

% this require robotics toolbox
% https://petercorke.com/toolboxes/robotics-toolbox/
grid on
hold on
axis equal

trplot(T0,'length',3,'frame','0')
trplot(T01,'length',6,'frame','1')
trplot(T02,'length',10,'frame','2')
trplot(T03,'length',10,'frame','3')
trplot(T04,'length',5,'frame','4')
% trplot(T05,'length',10,'frame','5')
trplot(T06,'length',10,'frame','6')
hold off
