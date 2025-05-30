function create_bullet(creator, x_coord, y_coord, firing_angle_offset, gun_type, damage)
{
	var bullets = instance_create_layer(
	x_coord,
	y_coord,
	layer,
	obj_bullets)
	{
		bullets.speed = 8 + random_range(-1,1);
		bullets.direction_angle = creator.rotation_angle + firing_angle_offset;
		bullets.direction = bullets.direction_angle;
		bullets.image_angle = bullets.direction_angle;
		bullets.x = x_coord;
		bullets.y = y_coord;
		bullets.creator = creator; // Store gun reference
		if (creator == obj_player_functions.id) bullets.gun_type = gun_type;
		else bullets.gun_type = noone;
		bullets.damage = damage;
		bullets.image_speed = 0;

		if (bullets.gun_type == 6)
		{
			bullets.life_timer = 20;
			bullets.image_scale = 1;
		}
		else 
		{
			bullets.life_timer = 200;
			bullets.image_scale = 1;
		}
	}	
}