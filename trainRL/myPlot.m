function myPlot(x_d,r)
sphere(30);
[x y z]=sphere();
s=surf(r*x+x_d(1),r*y+x_d(2),r*z+x_d(3),'FaceAlpha',0.5);
s.EdgeColor = 'none';
end