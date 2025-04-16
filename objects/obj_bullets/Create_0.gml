gun_parent = noone;
gun_type = 0;


life_timer = 400;
sprite = spr_bullets_1;
choose_sprite_index = 0;
image_multiply_scale = 1;
image_reduce_scale = image_multiply_scale;
image_yscale = image_multiply_scale*0.25;
image_xscale = image_multiply_scale*2.5;
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




//function get_bullet_sight_line(x_start, y_start, angle, target_object) 
//{
//    var max_distance = 800; 
//    var step_size = 2;        // How fine the collision check is
    
//    var x_end = x_start;
//    var y_end = y_start;
//	var line_length = max_distance;
    
//    for (var i = 0; i < max_distance; i += step_size) 
//	{
//        x_end = x_start + lengthdir_x(i, angle);
//        y_end = y_start + lengthdir_y(i, angle);
        
//        // Pixel-perfect collision check
//        if (position_meeting(x_end, y_end, target_object)) 
//		{
//			line_length = i;
//            break; // Stop when collision is detected
//        }
//    }
	
//    return [x_end, y_end];
//}

function get_bullet_sight_line(x_start, y_start, angle, target_object)
{
    var max_distance = 800; 
    var step_size = 2;

    var x_end = x_start;
    var y_end = y_start;
    
    var line_length = max_distance;
    
    for (var i = 0; i < max_distance; i += step_size) 
    {
        var test_x = x_start + lengthdir_x(i, angle);
        var test_y = y_start + lengthdir_y(i, angle);
        
        if (position_meeting(test_x, test_y, target_object)) 
        {
            line_length = i - 8;
            break;
        }
    }

    x_end = x_start + lengthdir_x(line_length, angle);
    y_end = y_start + lengthdir_y(line_length, angle);

    return [x_end, y_end];
}



counter = 0;
created = true;