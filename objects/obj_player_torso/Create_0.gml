image_scale = obj_player_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;

function get_sight_line(x_start, y_start, angle, target_object) {
    var max_distance = 10000; // Large value to simulate infinity
    var step_size = 1;        // How fine the collision check is
    
    var x_end = x_start;
    var y_end = y_start;
	var line_length = max_distance;
    
    for (var i = 0; i < max_distance; i += step_size) {
        x_end = x_start + lengthdir_x(i, angle);
        y_end = y_start + lengthdir_y(i, angle);
        
        // Pixel-perfect collision check
        if (position_meeting(x_end, y_end, target_object)) {
			line_length = i;
            break; // Stop when collision is detected
        }
    }
    draw_line(x_start,y_start,x_end,y_end);
	return line_length;

}

