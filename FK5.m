function T05 = FK5(theta1,theta2,theta3,theta4)
    s1 = sind(theta1);
    c1 = cosd(theta1);
    
    s2 = sind(theta2);
    c2 = cosd(theta2);
    
    s3 = sind(theta3);
    c3 = cosd(theta3);
    
    s4 = sind(theta4);
    c4 = cosd(theta4);
    
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
    T05 = A1*A2*A3*A4*A5;
end