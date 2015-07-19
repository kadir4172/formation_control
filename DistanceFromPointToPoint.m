function [DistanceFromPointToPoint] = DistanceFromPointToPoint(A, B)

	DistanceFromPointToPoint = sqrt ( ((A(1)-B(1)) * (A(1)-B(1))) + ((A(2)-B(2)) * (A(2)-B(2))) );



end

