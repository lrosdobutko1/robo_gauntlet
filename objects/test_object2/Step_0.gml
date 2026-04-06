if (keyboard_check(vk_space))
image_angle +=0.2;


function Change_Position_Of_Object_Origin()
{
	if (position_meeting(mouse_x, mouse_y, test_object2))
	{
	    if (mouse_check_button_pressed(mb_left))
	    {
        
	        var dx = mouse_x - x;
	        var dy = mouse_y - y;
        
	        var dist = point_distance(0, 0, dx, dy);
	        var dir  = point_direction(0, 0, dx, dy);
        
	        var local_dir = dir - image_angle;

	        var local_x = lengthdir_x(dist, local_dir);
	        var local_y = lengthdir_y(dist, local_dir);
        
	        var offset_x = local_x + sprite_xoffset;
	        var offset_y = local_y + sprite_yoffset;

	        sprite_set_offset(sprite_index, offset_x, offset_y);

	        x = mouse_x;
	        y = mouse_y;
	    }
	}
}