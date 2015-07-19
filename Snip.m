function [ Snip ] = Snip(u, v, w, n, V, m_points)
	%p;
    Math_Epsilon = 0.0001;
	A = m_points(:,V(u));
	B = m_points(:,V(v));
	C = m_points(:,V(w));
	if (Math_Epsilon > (((B(1) - A(1)) * (C(2) - A(2))) - ((B(2) - A(2)) * (C(1) - A(1)))))
		Snip = 0;
        return;
    end
	%for (p = 0; p < n; p++) 
    for p = 1 : 1 : n
		if ((p == u) || (p == v) || (p == w))
			continue;
        end
		P = m_points(:,V(p));
		if (InsideTriangle(A, B, C, P))
			Snip = 0;
            return;
        end
    end
    Snip = 1;
    return;
    %return 1;

end

