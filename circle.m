function circle(x,z,r)
    aplha=0:pi/40:2*pi;
    x1=r*cos(aplha)+x;
    z1=r*sin(aplha)+z;
    plot3(x1,zeros(length(z1)),z1,'-');
end