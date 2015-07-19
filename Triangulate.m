function [Triangle_List] = Triangulate(m_points)
%kare
%m_points= [0 1 1 0; 0 0 1 1];
%5gen

triangle_indexes = [];
%var indices = new Array();
n = length(m_points);

	if (n < 3)
		return
    end

%	app.activeDocument.pathItems.add().setEntirePath (m_points);

	V = [];
	if (Area_fractal(m_points) > 0)
		%for v = 0; v < n; v++
        for v = 1 : 1 : n
			V(v) = v;
        end
	else
	
		%for (var v = 0; v < n; v++)
        for v = 1 : 1 : n
			V(v) = n + 1 - v;
        end
	
    end
Alan  = Area_fractal(m_points);


	nv = n + 1;
	count = 2 * (nv-1);
    %m = 1;
    v = nv;
	%for (var m = 0, v = nv - 1; nv > 2; )
    while(nv > 3)
    
    %for (m = 0, v = nv - 1; nv > 2; )
	    if ((count) <= 0)
			%return indices ;
            return
        end
        count = count - 1;

		u = v;
		if (nv <= u)
			%u = 0;
            u = 1;
        end
		v = u + 1;
		if (nv <= v)
			%v = 0;
            v = 1;
        end
		w = v + 1;
		if (nv <= w)
			%w = 0;
            w = 1;
        end
u_tmp = u;
v_tmp = v;
w_tmp = w;
V_tmp = V;
		if (Snip(u, v, w, nv-1, V, m_points))
             
		%if(1)
			%var a, b, c, s, t;
			a = V(u);
			b = V(v);
			c = V(w);
			%indices.push(a);
            triangle_indexes = [triangle_indexes a];
			%indices.push(b);
            triangle_indexes = [triangle_indexes b];
			%indices.push(c);
            triangle_indexes = [triangle_indexes c];
			%m = m + 1;
            s = v;
			%for (s = v, t = v + 1; t < nv; s++, t++)
            for t = v + 1 : 1 : nv-1
                if(t == v + 1)
                 s = v;
                end
                V(s) = V(t);
                
                 s = s + 1;
                
				
            end
			    nv = nv - 1;
			    count = 2 * nv;
        end
    end

	%indices.reverse();
	%return indices;
    Triangle_List = triangle_indexes;
    return
end
