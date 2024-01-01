function display_robot(theta1,theta2,theta3,theta4,theta5)
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
    
    A1 = [c1 -s1 0 0;
        s1 c1 0 0;
        0 0 1 0;
        0 0 0 1];
    A2 = [c2 -s2 0 0;
        0 0 -1 0;
        s2 c2 0 11;
        0 0 0 1];
    A3 = [c3 -s3 0 44;
        s3 c3 0 0;
        0 0 1 0;
        0 0 0 1];
    A4 = [c4 -s4 0 55;
        s4 c4 0 0;
        0 0 1 0;
        0 0 0 1];
    A5 = [0 -1 0 10;
        1 0 0 0;
        0 0 1 0;
        0 0 0 1];
    A6 = [c5 -s5 0 0;
        0   0  -1 0 ;
        s5  c5 0 0;
        0   0  0 1];
    
    T0 = eye(4,4);
    T01 = A1;
    T02 = A1*A2;
    T03 = A1*A2*A3;
    T04 = A1*A2*A3*A4;
    T05 = A1*A2*A3*A4*A5;
    T06 = A1*A2*A3*A4*A5*A6;
    x = [T01(1,4),T02(1,4),T03(1,4),T04(1,4),T05(1,4),T06(1,4)];
    y = [T01(2,4),T02(2,4),T03(2,4),T04(2,4),T05(2,4),T06(2,4)];
    z = [T01(3,4),T02(3,4),T03(3,4),T04(3,4),T05(3,4),T06(3,4)];
    plot3(x,y,z);
    hold on;
    grid on;
    view(56,12)
    % trplot(T0,'length',3,'frame','0')
    trplot(T01,'length',5,'frame','1','notext','rgb')
    trplot(T02,'length',5,'frame','2','notext','rgb')
    trplot(T03,'length',5,'frame','3','notext','rgb')
    trplot(T04,'length',5,'frame','4','notext','rgb')
    % trplot(T05,'length',10,'frame','5')
    trplot(T06,'length',5,'frame','6','notext','rgb')
    xlim([-30 90]);
    ylim([-60 60]);
    zlim([0 120]);
    axis equal;
    hold off;
end

