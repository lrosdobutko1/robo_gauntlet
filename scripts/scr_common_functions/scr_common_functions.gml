function shoot_bullets(
creator,
gun_barrel_coords, 
firing_speed, 
firing_offset, 
gun_type,
firing_angle_offset,
num_bullets,
damage
)
{
	
	var bullet_loop_create_start = 0 - ((num_bullets - 1) / 2);
	
	for (var i = bullet_loop_create_start; i <= num_bullets; i++)
	{
			create_bullet(
			creator, 
			gun_barrel_coords[0], 
			gun_barrel_coords[1],
			firing_angle_offset*i, 
			gun_type, 
			damage);
	}
	
}


function create_bullet(_creator, _x_coord, _y_coord, _firing_angle_offset, _gun_type, _damage)
{
	show_debug_message("shooting bullets");
	// Prevent trying to use a non-existent creator
    if (!instance_exists(_creator)) return;
	
	
	var bullets = instance_create_layer(
	_x_coord,
	_y_coord,
	layer,
	obj_bullets)
	{
		bullets.speed = 8 + random_range(-1,1);
		bullets.direction_angle = _creator.rotation_angle + _firing_angle_offset;
		bullets.direction = bullets.direction_angle;
		bullets.image_angle = bullets.direction_angle;
		bullets.x = _x_coord;
		bullets.y = _y_coord;
		bullets.creator = _creator; // Store gun reference
		if (_creator == obj_player_functions.id) bullets.gun_type = _gun_type;
		else bullets._gun_type = noone;
		bullets.damage = _damage;
		bullets.image_speed = 0;

		//if (bullets.gun_type == 6)
		//{
		//	bullets.life_timer = 20;
		//	bullets.image_scale = 1;
		//}
		//else 
		//{
		//	bullets.life_timer = 200;
		//	bullets.image_scale = 1;
		//}
	}	
}

function camera_shake()
{	
	if (!global.shaking)
	{

	global.shaking = true;
	
	var shake_coefficient = max((1 - (distance_to_object(obj_player_collision) / 300)), 0.05);
	var camera_shake_x = random_range(-10,10);
	var camera_shake_y = random_range(-10,10);
	obj_camera.x += camera_shake_x * shake_coefficient;
	obj_camera.y += camera_shake_y * shake_coefficient;
}

}


