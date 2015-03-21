[conv_shape_x conv_shape_y] = calc_convex_shape(obstacle_1_x, obstacle_1_y);

[total_shape_x, total_shape_y] = calc_minkowski_sum( conv_shape_x, conv_shape_y, 5);

[minkowski_shape_x minkowski_shape_y] = calc_convex_shape(total_shape_x, total_shape_y);