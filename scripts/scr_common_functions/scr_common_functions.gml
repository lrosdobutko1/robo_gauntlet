
function create_bullet_types(_name, _damage, _speed, _timer, _sprite){
    return {
        bullet_name: _name,
        damage: _damage,
		bullet_speed: _speed,
		life_timer: _timer,
        sprite: _sprite
    };
}


/// @function shoot_bullets
/// @description Shoots a bullet of a given type, to be chosen dynamically
/// @param {string} _creator The object that created the bullet
/// @param {real}	_gun_barrel_x		    The x coordinate to create at
/// @param {real}	_gun_barrel_y		    The y coordinate to create at
/// @param {real}	_firing_offset		    The ratio to offset left and right firing
/// @param {struct}	_gun_type			    The bullet type to set the bullet to on creation
/// @param {real}	_firing_angle_offset	The angle to fire multiple bullets at
/// @param {real}	_num_bullets			The number of bullets to create and fire
/// @param {real}	_damage					The damage each bullet does on collision
function shoot_bullets(
_creator,
_gun_barrel_x, 
_gun_barrel_y,
_bullet_type,
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
	        _bullet_type,
	        _damage
	    );
	}
}


function create_bullet(
_creator, 
_x_coord, 
_y_coord, 
_firing_angle_offset, 
_bullet_type, 
_damage)
{
	
	// Prevent trying to use a non-existent creator
    if (!instance_exists(_creator)) return;
	
	var bullets = instance_create_layer(
    _x_coord,
    _y_coord,
    layer,
    obj_bullets,
    {
        creator:		_creator,
        bullet_type:	_bullet_type,
        angle_offset:	_firing_angle_offset,
        damage:    _damage
    }
);
	
	
	//var bullets = instance_create_layer(
	//_x_coord,
	//_y_coord,
	//layer,
	//obj_bullets)
	//{
	//	bullets.creator = _creator; 
		
	//	if (bullets.creator != obj_player_functions.id) 
	//	bullets.current_bullet_type = bullets.enemy_default
	//	else
	//	bullets.current_bullet_type = _bullet_type;
		
	//	bullets.direction = _creator.rotation_angle  + _firing_angle_offset;
	//	bullets.image_angle = _creator.rotation_angle + _firing_angle_offset;
	//	bullets.x = _x_coord;
	//	bullets.y = _y_coord;
	//	bullets.sprite_index = bullets.current_bullet_type.sprite;
	//	bullets.life_timer = bullets.current_bullet_type.life_timer;
	//	bullets.speed = bullets.current_bullet_type.bullet_speed;
	//	if (bullets.current_bullet_type.bullet_name == "Flamer") bullets.rotation = random(359);
	//	else rotation = 0;
	//}	
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

function cause_damage(_damage_amount) {
	
	self.hp -= _damage_amount;
	self.flash = 4;
	
}



























