function movej(angles1,angles2,step)
    for time = 0:1:step
        t1 = angles1(1) + ((angles2(1)-angles1(1))/step)*time;
        t2 = angles1(2) + ((angles2(2)-angles1(2))/step)*time;
        t3 = angles1(3) + ((angles2(3)-angles1(3))/step)*time;
        t4 = angles1(4) + ((angles2(4)-angles1(4))/step)*time;
        t5 = angles1(5) + ((angles2(5)-angles1(5))/step)*time;
        display_robot(t1,t2,t3,t4,t5);
        drawnow;
    end
end

