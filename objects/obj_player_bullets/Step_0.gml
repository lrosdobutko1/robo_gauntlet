life_timer --;

if (life_timer <= 0 || (place_meeting(x + speed, y + speed, obj_obstacle)))
{
	instance_destroy();
}


