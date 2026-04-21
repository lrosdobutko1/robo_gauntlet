life_time = 150;
activate_timer = 40;
image_size = 0.25;
image_xscale = image_size;
image_yscale = image_size;

image_speed = 0;
image_index = 0;

active = false;
launch_speed = random_range(1,2);
turn_radius = 2;
speed = launch_speed;
target = noone;

if (instance_exists(obj_enemy_basic_gunner))
{
	target = instance_nearest(x,y, obj_enemy_basic_gunner);
}

alive = true;
explode_anim = 0;
damage = 10;
hit = false;
