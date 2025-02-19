life_timer --;
if (type = BULLET_TYPE.MISSILE && speed < 10*global.delta_multiplier)
{
	speed *= 1.05;	
}

if image_index > 3
{
	image_index = use_image_index;
	image_speed = 0;
}


//create sparks if an object is struck
var x_offset = lengthdir_x(speed*global.delta_multiplier, direction);
var y_offset = lengthdir_y(speed*global.delta_multiplier, direction);

if (life_timer <= 0 || (place_meeting(x + x_offset, y + y_offset, obj_obstacle)))
{
	instance_destroy();
}


