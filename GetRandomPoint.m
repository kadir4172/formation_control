function [ GetRandomPoint ] = GetRandomPoint( triangle )

	%var Ax,Ay,Bx,By,Cx,Cy, a,b,c, Px,Py;

	Ax = triangle(1,1);
	Ay = triangle(1,2);
	Bx = triangle(2,1);
	By = triangle(2,2);
	Cx = triangle(3,1);
	Cy = triangle(3,2);

    a = rand(1);
    b = rand(1);
	while (a + b >= 1);
        a = rand(1);
		b = rand(1);
    end

	c = 1-a-b;
	Px = a*Ax + b*Bx + c*Cx;
	Py = a*Ay + b*By + c*Cy;

	GetRandomPoint = [Px,Py];

end

