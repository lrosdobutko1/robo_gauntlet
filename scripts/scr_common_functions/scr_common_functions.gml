function create_bullet(creator, x_coord, y_coord, firing_angle_offset, gun_type, damage)
{
	
	// Prevent trying to use a non-existent creator
    if (!instance_exists(creator)) return;
	
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

function camera_shake()
{	
	global.shake_call_count += 1;
	
	var shake_coefficient = max(1 - (distance_to_object(obj_player_collision) / 300) * 0.9, 0.1);
	var camera_shake_x = random_range(-5,5)
	var camera_shake_y = random_range(-5,5)
	obj_camera.x += camera_shake_x * shake_coefficient;
	obj_camera.y += camera_shake_y * shake_coefficient;
	show_debug_message(global.shake_call_count);
		
}

