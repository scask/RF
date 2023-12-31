point1 = FK(0,130,-130,0,0);
angles1 = IK(point1);

point2 = FK(0,90,-90,-45,0);
angles2 = IK(point2);

point3 = FK(45,45,-30,25,55);
angles3 = IK(point3);

point4 = FK(-45,45,-30,25,-55);
angles4 = IK(point4);

point5 = FK(0,15,-15,0,0);
angles5 = IK(point5);

point6 = FK(0,135.69,-156.28,20.59,90);
angles6 = IK(point6);

movej(angles1,angles2,50);
movej(angles2,angles3,100);
movej(angles3,angles4,100);
movej(angles4,angles5,100);
movel(angles5,angles6,100);


