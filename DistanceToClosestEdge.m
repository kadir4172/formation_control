function [DistanceToClosestEdge] = DistanceToClosestEdge( pt, edgelist )

	d2 = FastClosestPointOnLine (pt, edgelist(:,:,1));
	p = 1;
	%while (p<edgelist.length)
    while (p < length(edgelist)+1)
		testd = FastClosestPointOnLine (pt, edgelist(:,:,p));
		if (testd < d2)
		  d2 = testd;
        end

		p = p + 1;
    end
	DistanceToClosestEdge =  sqrt(d2);
end

