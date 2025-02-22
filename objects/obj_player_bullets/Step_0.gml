life_timer --;

if (life_timer <= 0 || (place_meeting(x + x_offset, y + y_offset, obj_obstacle)))
{
	instance_destroy();
}


