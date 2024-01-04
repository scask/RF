point1 = FK(0,130,-130,0,0);
angles1 = IK(point1)

point2 = FK(0,90,-90,-45,0);
angles2 = IK(point2)

point3 = FK(45,45,-30,25,55);
angles3 = IK(point3)

point4 = FK(-45,45,-30,25,-55);
angles4 = IK(point4)

point5 = FK(0,15,-15,0,0);
angles5 = IK(point5)

point6 = FK(0,135.69,-156.28,20.59,90);
angles6 = IK(point6)

hold on
grid on
axis equal
scatter3(point1(1,4),point1(2,4),point1(3,4))
scatter3(point2(1,4),point2(2,4),point2(3,4))
scatter3(point3(1,4),point3(2,4),point3(3,4))
scatter3(point4(1,4),point4(2,4),point4(3,4))
scatter3(point5(1,4),point5(2,4),point5(3,4))
scatter3(point6(1,4),point6(2,4),point6(3,4))
text(point1(1,4),point1(2,4),point1(3,4),'point1')
text(point2(1,4),point2(2,4),point2(3,4),'point2')
text(point3(1,4),point3(2,4),point3(3,4),'point3')
text(point4(1,4),point4(2,4),point4(3,4),'point4')
text(point5(1,4),point5(2,4),point5(3,4),'point5')
text(point6(1,4),point6(2,4),point6(3,4),'point6')
input('any key to continue')

movej(angles1,angles2,50);
movej(angles2,angles3,100);
movej(angles3,angles4,100);
movec(angles4,angles6,angles3,100)
movej(angles3,angles6,100);
movel(angles6,angles5,100);

