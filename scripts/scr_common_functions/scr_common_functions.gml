function shoot_bullets(
_creator,
_gun_barrel_x, 
_gun_barrel_y,
_firing_speed, 
_firing_offset, 
_gun_type,
_firing_angle_offset,
_num_bullets,
_damage
)
{
	var half = (_num_bullets - 1) / 2;

	for (var i = 0; i < _num_bullets; i++)
	{
	    var angle = (i - half) * _firing_angle_offset;

	    create_bullet(
	        _creator,
	        _gun_barrel_x,
	        _gun_barrel_y,
	        angle,
	        _gun_type,
	        _damage
	    );
	}
	
}


function create_bullet(_creator, _x_coord, _y_coord, _firing_angle_offset, _gun_type, _damage)
{
	
	// Prevent trying to use a non-existent creator
    if (!instance_exists(_creator)) return;

	
	var bullets = instance_create_layer(
	_x_coord,
	_y_coord,
	layer,
	obj_bullets)
	{
		bullets.bullet_speed = 8 + random_range(-0.5, 0.5);
		bullets.speed = bullets.bullet_speed;
		//bullets.direction_angle = _creator.rotation_angle + _firing_angle_offset;
		bullets.direction = _creator.rotation_angle + _firing_angle_offset;
		bullets.image_angle = _creator.rotation_angle + _firing_angle_offset;
		bullets.x = _x_coord;
		bullets.y = _y_coord;
		bullets.creator = _creator; // Store gun reference
		if (_creator == obj_player_functions.id) {
			bullets.current_bullet_type = _gun_type;
			bullets.image_index = spr_player_bullet_cannon;
		}
		else bullets._gun_type = noone;
		bullets.damage = _damage;
		bullets.image_speed = 0;
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


