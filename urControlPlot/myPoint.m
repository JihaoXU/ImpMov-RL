function myPoint(x_d,c)
sphere(30);
[x,y,z]=sphere();
r=8;
s=surf(r*x+x_d(1),r*y+x_d(2),r*z+x_d(3));
s.EdgeColor = 'none';
s.FaceLighting='gouraud';
s.FaceColor=c;
end