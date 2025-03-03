
speed--;

var tilemap = layer_tilemap_get_id("level_tiles")

var tile = tilemap_get_at_pixel(tilemap, x, y)

if (rotation_frames > 0)
{
    image_angle += rotation_speed; 
    rotation_frames--;                 
}

life_time --;

if (life_time <= 0)
{
	instance_destroy();
}


if (tile !=0)
{
	
	image_scale += scale_direction *0.24;
	if (image_scale >= 1.5)
	{
		scale_direction = -1;
	}


	else if (image_scale < .75)
	{
		scale_direction = 0;
	}
}
else
{
	image_scale -= 0.24
	if image_scale < 0 image_scale = 0;
}

if (place_meeting(x,y, obj_obstacle))
{
	direction = direction - 180;
	speed = speed/1.5;
}

if (speed <= 0)
{
	speed = 0;
}

image_xscale = image_scale;
image_yscale = image_scale;

