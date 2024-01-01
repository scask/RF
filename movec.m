function movec(angles1,angles2,angles3,step)
    pos1 = FK(angles1(1),angles1(2),angles1(3),angles1(4),angles1(5));
    pos2 = FK(angles2(1),angles2(2),angles2(3),angles2(4),angles2(5));
    pos3 = FK(angles3(1),angles3(2),angles3(3),angles3(4),angles3(5));
    p_start = [pos1(1,4), pos1(2,4), pos1(3,4)];
    p_mid   = [pos2(1,4), pos2(2,4), pos2(3,4)];
    p_final = [pos3(1,4), pos3(2,4), pos3(3,4)];
    a = norm(p_final - p_mid);           %内接三角形边长a
    b = norm(p_final - p_start);         %内接三角形边长b
    c = norm(p_mid - p_start);           %内接三角形边长c
    % l = (a + b + c) / 2;   %内接三角形半周长
    % r = a*b*c/ 4 / sqrt(l*(l - a)*(l - b)*(l - c)); %轨迹圆半径
    % solution = [p_start(1) p_start(2) p_start(3) ; p_mid(1) p_mid(2) p_mid(3) ; p_final(1) p_final(2) p_final(3) ] \ [1;1;1];
    b1 = a*a * (b*b + c*c - a*a);
    b2 = b*b * (a*a + c*c - b*b);
    b3 = c*c * (a*a + b*b - c*c);
    P1 = [p_start'  p_mid'  p_final'];
    P2 = [b1; b2; b3];
    P3 = P1 * P2;
    center = P3 ./ (b1 + b2 + b3);
    center = center';%转置
    vector_start_big = p_start - center;                          %由圆心指向起点的向量
    vector_start = (p_start - center) ./ norm(p_start - center);  %由圆心指向起点的单位向量
    vector_final = (p_final - center) ./ norm(p_start - center);  %由圆心指向终点的单位向量
    rotation_axis = cross(vector_start,vector_final);
    rotation_axis = rotation_axis ./ norm(rotation_axis);
    rotation_axis = rotation_axis';
    theta = acos(dot(vector_start , vector_final));%弧度制的圆弧角度
    theta = rad2deg(theta);%角度制的圆弧角度
    theta_per = theta / step;%角度制的每个轨迹点之间的角度
    for t = 0:1:step 
        theta_current = t * theta_per;
        % rodrigues rotation formula
        matrix_current = cosd(theta_current)*eye(3)+((1-cosd(theta_current))*(rotation_axis*rotation_axis'))+sind(theta_current)*skew(rotation_axis);
        vector_current = matrix_current * (vector_start_big');  %使向量绕旋转轴旋转
        p_current = center + vector_current';             %轨迹点坐标 
        Nx = pos1(1,1) + ((pos3(1,1)-pos1(1,1))/step)*t;
        Ny = pos1(2,1) + ((pos3(2,1)-pos1(2,1))/step)*t;
        Nz = pos1(3,1) + ((pos3(3,1)-pos1(3,1))/step)*t;
        Ox = pos1(1,2) + ((pos3(1,2)-pos1(1,2))/step)*t;
        Oy = pos1(2,2) + ((pos3(2,2)-pos1(2,2))/step)*t;
        Oz = pos1(3,2) + ((pos3(3,2)-pos1(3,2))/step)*t;
        Ax = pos1(1,3) + ((pos3(1,3)-pos1(1,3))/step)*t;
        Ay = pos1(2,3) + ((pos3(2,3)-pos1(2,3))/step)*t;
        Az = pos1(3,3) + ((pos3(3,3)-pos1(3,3))/step)*t;
        T06 = [Nx Ox Ax p_current(1);
               Ny Oy Ay p_current(2);
               Nz Oz Az p_current(3);
               0 0 0 1];
        anglest = IK(T06);
        display_robot(anglest(1),anglest(2),anglest(3),anglest(4),anglest(5));
        drawnow;
    end
end

