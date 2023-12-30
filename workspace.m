hold on
grid on
axis equal

for t1 = 0
    for t2 = 0:20:150
        for t3 = -0:-20:-160
            for t4 = -90:30:90
                endPoint = FK(t1,t2,t3,t4,0);
                scatter3(endPoint(1,4),endPoint(2,4),endPoint(3,4))
            end
        end
    end
end

view(0,0)

% circle(350,675,1350+1220);
% circle(350-1350*cosd(40),675+1350*sind(40),1220);
% circle(350+1350,675,1220);
% circle(350,675,651.58-105.56);
