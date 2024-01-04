function movec(angles1,angles2,angles3,step)
    pos1 = FK(angles1(1),angles1(2),angles1(3),angles1(4),angles1(5));
    pos2 = FK(angles2(1),angles2(2),angles2(3),angles2(4),angles2(5));
    pos3 = FK(angles3(1),angles3(2),angles3(3),angles3(4),angles3(5));
    % points on the circle
    p_start = [pos1(1,4), pos1(2,4), pos1(3,4)];
    p_mid   = [pos2(1,4), pos2(2,4), pos2(3,4)];
    p_final = [pos3(1,4), pos3(2,4), pos3(3,4)];
    % inscribed triangle edge length
    a = norm(p_final - p_mid);
    b = norm(p_final - p_start);
    c = norm(p_mid - p_start);
    % get the center of the circle
    b1 = a*a * (b*b + c*c - a*a);
    b2 = b*b * (a*a + c*c - b*b);
    b3 = c*c * (a*a + b*b - c*c);
    P1 = [p_start'  p_mid'  p_final'];
    P2 = [b1; b2; b3];
    P3 = P1 * P2;
    center = P3 ./ (b1 + b2 + b3);
    center = center';
    % vectors pointing to trajtory points from center
    vector_start_big = p_start - center;
    % normalize
    vector_start = (p_start - center) ./ norm(p_start - center);
    vector_final = (p_final - center) ./ norm(p_start - center);
    % get the rotaion axis that is pointing outwards from center
    rotation_axis = cross(vector_start,vector_final);
    rotation_axis = rotation_axis ./ norm(rotation_axis);
    rotation_axis = rotation_axis';
    % how much should the vector turn from start to end
    theta = acos(dot(vector_start , vector_final));
    theta = rad2deg(theta);
    theta_per = theta / step;
    for t = 0:1:step 
        theta_current = t * theta_per;
        % rodrigues rotation formula (the rotation matrix for a theta degree along the axis)
        matrix_current = cosd(theta_current)*eye(3)+((1-cosd(theta_current))*(rotation_axis*rotation_axis'))+sind(theta_current)*skew(rotation_axis);
        % turn the initial vector
        vector_current = matrix_current * (vector_start_big');
        % then we can get the current point on the circle
        p_current = center + vector_current';
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

