%clear all
%close all
%clc
%pen
agents_radius = [0.18 0.36 0.6]; % 20 20 10 
%agents_radius = evalin('base', 'agents_radius');
formation_density = evalin('base', 'probable_density');

maxCircleSize = 10;
minCircleSize = 10;
m_points = [formation_x ; formation_y];
outerPath = m_points;

%densiy - distance table
%density = [0.08 0.11 0.125 0.15 0.17 0.21];
%mindist = [1.23 0.9  0.8   0.7  0.55 0.45];
  %fitted line 
  %y = -5.8054 * x + 1.4893;
  %fitted line 

minDistanceToOtherCircles = -5.8054 * formation_density + 1.3293
%densiy - distance table
 
if (maxCircleSize < 0.01 || maxCircleSize > 100)

			maxCircleSize = 20;
end
	
		if (minCircleSize < 0.01 || minCircleSize > maxCircleSize)
		
			minCircleSize = maxCircleSize/2;
        end
		maxCircleSize = maxCircleSize / 100;	% Convert percentage to decimal fraction
		minCircleSize = minCircleSize / 100;

		maxCircleSize = maxCircleSize / 2;	  % Convert diameter to radius
		minCircleSize = minCircleSize / 2;







minx = min(m_points(1,:));
miny = min(m_points(2,:));

maxx = max(m_points(1,:));
maxy = max(m_points(2,:));
			

if (minx > maxx)
  x = minx;
  minx = maxx;
  maxx = x;
end

if (miny > maxy)
  y = miny;
  miny = maxy;
  maxy = y;
end
maxwide = maxx - minx;
maxhigh = maxy - miny;

totalArea = Area_fractal(m_points);
filledArea = 0;

Math_Epsilon = 0.0001;
joinedPath = outerPath;
triangleIndexList = Triangulate (joinedPath);
%{
output =  delaunayTriangulation(formation_x',formation_y');
temp = size(output);
temp = temp(1);
triangleIndexList = [];
triangleList = [];
for(i = 1 :  1 : temp)
triangleIndexList = [triangleIndexList output(i,:)];
end
triangleIndexList = triangleIndexList'; 
%}
triangleList = [];
for p = 1 : 3 : length(triangleIndexList)
	triangleList  = [triangleList joinedPath(:,triangleIndexList(p)) joinedPath(:,triangleIndexList(p+1)) joinedPath(:,triangleIndexList(p+2))];
end
                    
% Store edges in pairs, most left x first
edgeList = [];
counter_edgeList = 1;
if (outerPath(1,1) < outerPath(1,length(outerPath)))
  %edgeList.push ( [ outerPath[0], outerPath[outerPath.length-1] ] );
  edgeList(:,:,counter_edgeList) = [outerPath(1,1) outerPath(2,1); outerPath(1,end) outerPath(2,end)];
  counter_edgeList = counter_edgeList + 1;
else
  edgeList(:,:,counter_edgeList) = [outerPath(1,end) outerPath(2,end); outerPath(1,1) outerPath(2,1)];
  counter_edgeList = counter_edgeList + 1;    
end
 
%for (i=0; i<outerPath.length-1; i++)
for i= 1 : 1 : length(outerPath)-1
  if (outerPath(1,i) < outerPath(1,i+1))
  
    edgeList(:,:,counter_edgeList) = [outerPath(1,i) outerPath(2,i); outerPath(1,i+1) outerPath(2,i+1)];
    counter_edgeList = counter_edgeList + 1;    
  else
  
    edgeList(:,:,counter_edgeList) = [outerPath(1,i+1) outerPath(2,i+1); outerPath(1,i) outerPath(2,i)];
    counter_edgeList = counter_edgeList + 1;    
  end
end

areaList = [];
triArea = 0;
%for (p=0; p<triangleList.length; p++)
for p = 1 : 3 : length(triangleList)
    P1 = triangleList(:,p);
    P2 = triangleList(:,p+1);
    P3 = triangleList(:,p+2);
    
	dummy  = Triangle_area([P1'; P2'; P3']);
    triArea = triArea + abs(dummy);
    areaList = [areaList triArea];
end

pointList  = [];
circleList = [];
radiiList = agents_radius;
maxsize    = sqrt(maxwide * maxhigh);
sizecircle       = maxCircleSize;
                
%while (1)
%  radiiList = [radiiList sizecircle*maxsize]
%  sizecircle = sizecircle * .667;
%  if (sizecircle < minCircleSize)
%    break;
%  end
%end
   test = 1;            
   sayac = 0;
%for (rad=0; rad<radiiList.length; rad++)
for rad = 1 : 1 : length(radiiList)
					%for (p=0; p<1000; p++)
                    counter = 0;
                     %  for q_tmp = 1 : 1 : (length(triangleList)/3)
                     %      q=q_tmp;
                    for p = 1 : 1 : 1000
					    if(rad == 3 & counter == 10)
                            break;
                        elseif(counter == 20)
                            break;
                        end
						a_rnd = rand(1) * triArea;
						%for (q=0; q<triangleList.length; q++)
                        for q_tmp = 1 : 1 : (length(triangleList)/3)
							if (areaList(q_tmp) > a_rnd)
                                q = q_tmp;
                               %q = length(triangleList)-1;
								break;
                            end
                        end
                        P1 = triangleList(:,3*(q-1) +1);
                        P2 = triangleList(:,3*(q-1) +2);
                        P3 = triangleList(:,3*(q-1) +3);
						pt = GetRandomPoint ([P1' ; P2'; P3']);
						d = DistanceToClosestEdge (pt, edgeList);
						if (d >= radiiList(rad))
			
                            c = 0;
                         	%for (c=0; c<pointList.length; c++)
                            tmp = size(pointList);
                            tmp = tmp(1);
                            c = -1;
                            if(tmp >= 1)
                            for c_tmp = 1 : 1 : tmp
								
								xd = pt(1)-pointList(c_tmp,1);
								yd = pt(2)-pointList(c_tmp,2);
                                distance = sqrt(xd^2 + yd^2);
								%if ((xd <= (radiiList(rad)+circleList(c_tmp)+minDistanceToOtherCircles)) & (yd <= (radiiList(rad)+circleList(c_tmp)+minDistanceToOtherCircles)))
                                if(distance < (radiiList(rad)+circleList(c_tmp)+minDistanceToOtherCircles))
									d = DistanceFromPointToPoint (pt, pointList(c_tmp,:))-minDistanceToOtherCircles;
									if (d < radiiList(rad)+circleList(c_tmp))
									    c = c_tmp;
                                        break;                                        
                                    end
                                end
                                 c = -1;
                            end
                            end
                            %tmp = size(pointList);
                            %tmp = tmp(1);
                       		if (c == -1)
                            %if (1)
							    counter = counter + 1;
								nrad = radiiList(rad);
								%pointList.push ( pt );
                                pointList = [pointList; pt];
								%circleList.push (nrad);
                                circleList = [circleList nrad];
                            end
                        end
                    end
                     %  end
                    
end
%figure
%axis([-35,35,-35,35])
%hold on
%plot(pointList(:,1),pointList(:,2),'o')
% k = scatter(pointList(:,1), pointList(:,2), agents_zone_matlab);
%hold on
%plot(formation_x, formation_y, 'r')
if(length(circleList) < 50)
    yerlestirilebilen_robot_sayisi = length(circleList)
    GoalStateFractalPos1 = [];
    GoalStateFractalPos2 = [];
    GoalStateFractalPos3 = [];
else
    tmp = pointList(:,1);
    GoalStateFractalPos1 = pointList(1:20,:);
    GoalStateFractalPos2 = pointList(21:40,:);
    GoalStateFractalPos3 = pointList(41:50,:);
end 
  assignin('base', 'GoalStateFractalPos1', GoalStateFractalPos1);
  assignin('base', 'GoalStateFractalPos2', GoalStateFractalPos2);
  assignin('base', 'GoalStateFractalPos3', GoalStateFractalPos3);