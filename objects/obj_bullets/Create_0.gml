//gun_parent = noone;
//gun_type = 0;
direction = 0;
life_timer = 100;
sprite = spr_bullets_1;
choose_sprite_index = 0;
image_multiply_scale = 1;
image_reduce_scale = image_multiply_scale;
image_yscale = image_multiply_scale/2;
image_xscale = image_multiply_scale*4;
image_speed = 0;

sprite_set_offset
(
spr_bullets,
sprite_get_width(spr_bullets)/2,
sprite_get_height(spr_bullets)
);

damage_to_player = 0;
damage_to_enemy = 0;
crit = damage_to_enemy * 2.5;
bullet_speed = 0;

function get_bullet_sight_line(x_start, y_start, angle, target_object) {
    var max_distance = 1000; 
    var step_size = 4; // How fine the collision check is
    
    var x_end = x_start;
    var y_end = y_start;
	var line_length = max_distance;
	var end_coords = [];
   
    for (var i = 0; i < max_distance; i += step_size) {
        x_end = x_start + lengthdir_x(i, angle);
        y_end = y_start + lengthdir_y(i, angle);
        
        if (position_meeting(x_end, y_end, target_object)) {
			line_length = i;
            break; 
        }
    }
    draw_line(x_start,y_start,x_end,y_end);
	return line_length;
}

counter = 0;