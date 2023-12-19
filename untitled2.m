%Part2
%% ROBOT MODEL
L=150;Sa=150;side_length = 400; r=100;
% PlantForm{B} BLUE
 % mm
R=side_length;
x_base = [0,side_length/2,side_length];
y_base = [0,side_length*sqrt(3)/2,0];

xb1 = x_base(1); yb1=y_base(1);
xb3 = x_base(2); yb3=y_base(2);
xb2 = x_base(3); yb2=y_base(3);
figure;
hold on;
plot(x_base([1, 2, 3, 1]), y_base([1, 2, 3, 1]), 'b', 'LineWidth', 2);
text(xb1, yb1, '1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(xb2, yb2, '2', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
text(xb3, yb3, '3', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

% modify PlantForm{C} Black
hold on
a=pi/6; xc=200;yc=150;
phi1=a+pi/6; phi2=a+5/6*pi; phi3=a+3/2*pi;

xs1=xc-r*cos(phi1); ys1=yc-r*sin(phi1);
xs2=xc-r*cos(phi2); ys2=yc-r*sin(phi2);
xs3=xc-r*cos(phi3); ys3=yc-r*sin(phi3);

x_Plant=[xs1;xs2;xs3];
y_plant=[ys1;ys2;ys3];

plot(x_Plant([1, 2, 3, 1]), y_plant([1, 2, 3, 1]), 'k', 'LineWidth', 2);
text(xs1, ys1, '1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(xs2, ys2, '2', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center');
text(xs3, ys3, '3', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
% Inverse Kinematics--calculate theta_i
c1 = atan2(ys1, xs1);
d1 = acos((Sa^2 - L^2 + xs1^2 + ys1^2) / (2 * Sa * sqrt(xs1^2 + ys1^2)));
theta1 = c1 +d1;

c2=atan2(ys2, xs2-R);
d2 = acos((Sa^2 - L^2 + (xs2-R)^2 + ys2^2) / (2 * Sa * sqrt((xs2-R)^2 + ys2^2)));
theta2=c2+d2;

c3=atan2(ys3-R*sqrt(3)/2,xs3-R*0.5);
d3=acos((Sa^2-L^2+(xs3-R*0.5)^2+(ys3-R*sqrt(3)/2)^2)/(2*Sa*sqrt((xs3-R*0.5)^2+(ys3-R*sqrt(3)/2)^2)));
theta3=c3+d3;

% Calculate joint jx and jy
jx1=Sa*cos(theta1);jy1=Sa*sin(theta1);
jx2=Sa*cos(theta2)+R;jy2=Sa*sin(theta2);
jx3=Sa*cos(theta3)+R*0.5;jy3=Sa*sin(theta3)+R*sqrt(3)/2;


% draw
plot([xs1, jx1], [ys1, jy1], 'g', 'LineWidth', 1); 
plot([xb1, jx1], [yb1, jy1], 'r', 'LineWidth', 1);
plot(jx1, jy1, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

plot([xs2, jx2], [ys2, jy2], 'g', 'LineWidth', 1); 
plot([xb2, jx2], [yb2, jy2], 'r', 'LineWidth', 1);
plot(jx2, jy2, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

plot([xs3, jx3], [ys3, jy3], 'g', 'LineWidth', 1); 
plot([xb3, jx3], [yb3, jy3], 'r', 'LineWidth', 1);
plot(jx3, jy3, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

%%%%%%%%%%%%%%%%%%%
axis equal;
title('RObOT');
xlabel('X (mm)');
ylabel('Y (mm)');
grid on;


%% PART3

M1 = [Sa*cos(theta1), Sa*sin(theta1)];

M2 = [Sa*cos(theta2)+R, Sa*sin(theta2)];

M3 = [R*0.5 + Sa*cos(theta3), R*sqrt(3)/2 + Sa*sin(theta3)];


% Confirm
disp(['M1 = (', num2str(M1(1)), ', ', num2str(M1(2)), ')']);
disp(['M2 = (', num2str(M2(1)), ', ', num2str(M2(2)), ')']);
disp(['M3 = (', num2str(M3(1)), ', ', num2str(M3(2)), ')']);
disp(['J1 = (', num2str(jx1), ', ', num2str(jy1), ')']);
disp(['J2 = (', num2str(jx2), ', ', num2str(jy2), ')']);
disp(['J3 = (', num2str(jx3), ', ', num2str(jy3), ')']);

% 
x0 = [150, 64, pi/3]; 

%  fsolve 
options = optimoptions('fsolve', 'Display', 'iter');
[PP, fval, exitflag, output] = fsolve(@(x) [
    (x(1) - M1(1))^2 + (x(2) - M1(2))^2 - L^2;
    ((x(1) + sqrt(3)*r*cos(x(3))) - M2(1))^2 + ((x(2) + sqrt(3)*r*sin(x(3))) - M2(2))^2 - L^2;
    ((x(1) + sqrt(3)*r*cos(x(3) + pi/3)) - M3(1))^2 + ((x(2) + sqrt(3)*r*sin(x(3) + pi/3)) - M3(2))^2 - L^2
], x0, options);

% result
disp(['PP1x = ', num2str(PP(1))]);
disp(['PP1y = ', num2str(PP(2))]);
disp(['A = ', num2str(PP(3))]);

PP1x=PP(1);
PP1y=PP(2);
A=PP(3);

PP2x = PP1x + sqrt(3) * r * cos(A);
PP2y = PP1y + sqrt(3) * r * sin(A);
PP3x = PP1x + sqrt(3) * r * cos(A + pi/3);
PP3y = PP1y + sqrt(3) * r * sin(A + pi/3);

disp(['PP2x = ', num2str(PP2x)]);
disp(['PP2y = ', num2str(PP2y)]);
disp(['PP3x = ', num2str(PP3x)]);
disp(['PP3y = ', num2str(PP3y)]);

%% Part2 workspace


% Parameters
L = 150; Sa = 150; side_length = 400; r = 100;
z_fixed = 100; % Fixed height for the z-axis

% Base platform {B} setup
R = side_length;
x_base = [0, side_length/2, side_length];
y_base = [0, side_length * sqrt(3) / 2, 0];

% Plotting base platform {B}
figure;
hold on;
plot3(x_base([1, 2, 3, 1]), y_base([1, 2, 3, 1]), z_fixed*ones(1, 4), 'b', 'LineWidth', 2);
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
title('Robot End Effector Workspace');
grid on;

% Modified platform {C} setup
a = pi/6; xc = 200; yc = 150;
phi1 = a + pi/6; phi2 = a + 5*pi/6; phi3 = a - pi/2;
xs1 = xc - r*cos(phi1); ys1 = yc - r*sin(phi1);
xs2 = xc - r*cos(phi2); ys2 = yc - r*sin(phi2);
xs3 = xc - r*cos(phi3); ys3 = yc - r*sin(phi3);

% Inverse Kinematics calculations
theta1 = atan2(ys1, xs1) - acos((Sa^2 - L^2 + xs1^2 + ys1^2) / (2 * Sa * sqrt(xs1^2 + ys1^2)));
theta2 = atan2(ys2, xs2-R) - acos((Sa^2 - L^2 + (xs2-R)^2 + ys2^2) / (2 * Sa * sqrt((xs2-R)^2 + ys2^2)));
theta3 = atan2(ys3-R*sqrt(3)/2, xs3-R/2) - acos((Sa^2 - L^2 + (xs3-R/2)^2 + (ys3-R*sqrt(3)/2)^2) / (2 * Sa * sqrt((xs3-R/2)^2 + (ys3-R*sqrt(3)/2)^2)));

% Workspace analysis
theta_range = linspace(-pi, pi, 100);
[X, Y, Z] = meshgrid(theta_range, theta_range, z_fixed);
X_end_effector = zeros(size(X));
Y_end_effector = zeros(size(Y));

% Calculate workspace
for i = 1:size(X, 1)
    for j = 1:size(Y, 2)
        % Calculate joint positions
        jx1 = Sa * cos(theta_range(i)) + x_base(1);
        jy1 = Sa * sin(theta_range(i)) + y_base(1);
        jx2 = Sa * cos(theta_range(j)) + x_base(2);
        jy2 = Sa * sin(theta_range(j)) + y_base(2);
        jx3 = Sa * cos(-theta_range(i)-theta_range(j)) + x_base(3);
        jy3 = Sa * sin(-theta_range(i)-theta_range(j)) + y_base(3);

        % Calculate end effector position (centroid of the triangle formed by joints)
        X_end_effector(i, j) = (jx1 + jx2 + jx3) / 3;
        Y_end_effector(i, j) = (jy1 + jy2 + jy3) / 3;
    end
end

% Plot workspace
plot3(X_end_effector(:), Y_end_effector(:), Z(:), 'r.');
hold off;



