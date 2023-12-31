function movel(angles1,angles2,step)
    pos1 = FK(angles1(1),angles1(2),angles1(3),angles1(4),angles1(5));
    pos2 = FK(angles2(1),angles2(2),angles2(3),angles2(4),angles2(5));
    for time = 0:1:step
        x = pos1(1,4) + ((pos2(1,4)-pos1(1,4))/step)*time;
        y = pos1(2,4) + ((pos2(2,4)-pos1(2,4))/step)*time;
        z = pos1(3,4) + ((pos2(3,4)-pos1(3,4))/step)*time;
        Nx = pos1(1,1) + ((pos2(1,1)-pos1(1,1))/step)*time;
        Ny = pos1(2,1) + ((pos2(2,1)-pos1(2,1))/step)*time;
        Nz = pos1(3,1) + ((pos2(3,1)-pos1(3,1))/step)*time;
        Ox = pos1(1,2) + ((pos2(1,2)-pos1(1,2))/step)*time;
        Oy = pos1(2,2) + ((pos2(2,2)-pos1(2,2))/step)*time;
        Oz = pos1(3,2) + ((pos2(3,2)-pos1(3,2))/step)*time;
        Ax = pos1(1,3) + ((pos2(1,2)-pos1(1,3))/step)*time;
        Ay = pos1(2,3) + ((pos2(2,3)-pos1(2,3))/step)*time;
        Az = pos1(3,3) + ((pos2(3,3)-pos1(3,3))/step)*time;
        T06 = [Nx Ox Ax x;
               Ny Oy Ay y;
               Nz Oz Az z;
               0 0 0 1];
        anglest = IK(T06);
        display_robot(anglest(1),anglest(2),anglest(3),anglest(4),anglest(5));
        drawnow;
    end
end