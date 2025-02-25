speed -= 0.05;
//if(speed <= 0) speed = 0;

life_time --;
activate_timer--;

if(life_time <= 0)
{
	instance_destroy();
}

if (activate_timer <= 0) 
{
	speed = 0;
	active = true;
}

if (active)
{
	image_speed = 1;
	direction = image_angle;
	speed = 12;
	
	instance_create_layer(x,y,layer,obj_rocket_smoke);
	if (instance_exists(obj_enemy_1))
	{
		target = instance_nearest(x,y, obj_enemy_1);
		var angle_diff = angle_difference(image_angle, point_direction(x,y,target.x,target.y));
		image_angle -= min(abs(angle_diff), turn_radius) * sign(angle_diff);
		turn_radius += 0.01;
	}

}

