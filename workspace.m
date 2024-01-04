hold on
grid on
axis equal

for t1 = 0 %-90:20:90
    for t2 = 0:20:160
        for t3 = -0:-20:-160
            for t4 = -90:30:90
                endPoint = FK(t1,t2,t3,t4,0);
                scatter3(endPoint(1,4),endPoint(2,4),endPoint(3,4))
            end
        end
    end
end

 view(0,0)
% view(45,45)
% circle(0,11,109);
% circle(44,11,65);
