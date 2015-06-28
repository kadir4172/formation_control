function [ InsideTriangle ] = InsideTriangle( A, B, C ,P )
	%var ax, ay, bx, by, cx, cy, apx, apy, bpx, bpy, cpx, cpy;
	%var cCROSSap, bCROSScp, aCROSSbp;

	ax = C(1) - B(1); ay = C(2) - B(2);
	bx = A(1) - C(1); by = A(2) - C(2);
	cx = B(1) - A(1); cy = B(2) - A(2);
	apx = P(1) - A(1); apy = P(2) - A(2);
	bpx = P(1) - B(1); bpy = P(2) - B(2);
	cpx = P(1) - C(1); cpy = P(2) - C(2);

	aCROSSbp = ax * bpy - ay * bpx;
	cCROSSap = cx * apy - cy * apx;
	bCROSScp = bx * cpy - by * cpx;

	InsideTriangle = ((aCROSSbp > 0.0) && (bCROSScp > 0.0) && (cCROSSap > 0.0));
end

