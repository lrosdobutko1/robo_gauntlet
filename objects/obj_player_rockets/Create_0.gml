life_time = 2000;
activate_timer = 40;
image_size = 0.5;
image_xscale = image_size;
image_yscale = image_size;

image_speed = 0;
image_index = 0;

active = false;
launch_speed = random_range(1,2);
turn_radius = 2;
speed = launch_speed;

if (instance_exists(obj_enemy_1))
{
	target = instance_nearest(x,y, obj_enemy_1);
}
