function [Alan] = Area_fractal(m_points)
	n = length(m_points);
	A = 0.0;
    %p = n - 1;
    %q = 0;
	%for (q < n; p = q++)
    for q = 1 : 1 : n
        if(q == 1)
         p = n;
        else
         p = q - 1;    
        end
        pval = m_points(:,p);
		qval = m_points(:,q);
		A = A + pval(1) * qval(2) - qval(1) * pval(2);
    end
	Alan =  A * 0.5;
end

