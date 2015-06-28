function [FastClosestPointOnLine] = FastClosestPointOnLine(pt, line)
	X1 = line(1,1);
    Y1 = line(1,2);
	X2 = line(2,1);
    Y2 = line(2,2);
	px = pt(1);
    py = pt(2);

	dx = X2 - X1;
	dy = Y2 - Y1;

	

	if (dx == 0 && dy == 0)
	
		% It's a point not a line segment.
		% dx = px - X1
		% dy = py - Y1
		% distance = Sqr(dx * dx + dy * dy)
		nx = X1;
		ny = Y1;
	 else
	
		% Calculate the t that minimizes the distance.
		t = ((px - X1) * dx + (py - Y1) * dy) / (dx * dx + dy * dy);

		% See if this represents one of the segment's
		% end points or a point in the middle.
		if (t <= 0)
		
			nx = X1;
			ny = Y1;
        elseif (t >= 1)
		
			nx = X2;
			ny = Y2;
		 else
		
			nx = X1 + t * dx;
			ny = Y1 + t * dy;
        end
    end

	dx = px - nx;
	dy = py - ny;

	FastClosestPointOnLine = dx * dx + dy * dy;


end

