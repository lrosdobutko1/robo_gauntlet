creator = 0;
sprite_set_offset
(
spr_bullets,
sprite_get_width(spr_bullets)/2,
sprite_get_height(spr_bullets)
);

life_timer = 200;
image_scale = 2;
image_xscale = image_scale/4;
image_yscale = image_scale;
image_speed = 0;

//if the bullet is created by an enemy
if (creator != obj_player_functions.id) 
{
	bullet_speed = 8;
	damage_to_player = 2;

}

damage_to_enemy = 1;

crit = damage_to_enemy * 2.5;

speed = bullet_speed * global.delta_multiplier;

image_index = 0;

function get_sight_line(x_start, y_start, angle, target_object) {
    var max_distance = 10000; 
    var step_size = 10; // How fine the collision check is
    
    var x_end = x_start;
    var y_end = y_start;
	var line_length = max_distance;
   
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