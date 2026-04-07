function find_gun_create_coordinates(coords, radius, spread_angle)
{
	
	//find the coordinates to create bullets at by calculating isoscoles triangle
	var x_fixed = x;
	var y_fixed = y;

	// Triangle parameters
	radius = radius * image_scale; // Distance from the fixed point to the other two points
	spread_angle = spread_angle; // Spread angle between the two equal points (in degrees)

	// Direction to the mouse
	var angle_to_mouse = point_direction(x_fixed, y_fixed, mouse_x, mouse_y);

	// Calculate the positions of the two equal points
	var angle1 = angle_to_mouse - spread_angle / 2; // First point's angle
	var angle2 = angle_to_mouse + spread_angle / 2; // Second point's angle

	coords[0] = x_fixed + lengthdir_x(radius, angle1);
	coords[1] = y_fixed + lengthdir_y(radius, angle1);
	coords[2] = x_fixed + lengthdir_x(radius, angle2);
	coords[3] = y_fixed + lengthdir_y(radius, angle2);
	
}



/// @function shoot_bullets
/// @description Shoots a bullet of a given type, to be chosen dynamically
/// @param {string} _creator The object that created the bullet
/// @param {real}	_gun_barrel_x		    The x coordinate to create at
/// @param {real}	_gun_barrel_y		    The y coordinate to create at
/// @param {struct}	bullet_type			    The bullet type to set the bullet to on creation
/// @param {real}	_firing_angle			The primary angle to fire multiple bullets at
/// @param {real}	_firing_angle_offset	The angle to fire multiple bullets at
/// @param {real}	_num_bullets			The number of bullets to create and fire
/// @param {real}	_damage					The damage each bullet does on collision
//function shoot_bullets(
//_creator,
//_gun_barrel_x, 
//_gun_barrel_y,
//_bullet_type,
//_firing_angle,
//_firing_angle_offset,
//_num_bullets,
//_damage,
//_bullet_speed
//)
//{
//	var half = (_num_bullets - 1) / 2;

//	for (var i = 0; i < _num_bullets; i++)
//	{
//	    var angle_offset = (i - half) * _firing_angle_offset;

//	    create_bullet(
//	        _creator,
//	        _gun_barrel_x,
//	        _gun_barrel_y,
//			_firing_angle,
//	        angle_offset,
//	        _bullet_type,
//	        _damage,
//			_bullet_speed
//	    );
//	}
//}


function create_bullet_types(_creator, _name, _bullet_damage, _speed, _timer, _sprite){
    return {
		creator:	   _creator,
        bullet_name:   _name,
		bullet_damage: _bullet_damage,
		bullet_speed:  _speed,
		life_timer:    _timer,
        sprite:	       _sprite
    };
}

function shoot_bullets(
_bullet_type,
_gun_barrel_x, 
_gun_barrel_y,
_num_bullets,
_firing_angle,
_firing_angle_offset
)
{
	
	var half = (_num_bullets - 1) / 2;

	for (var i = 0; i < _num_bullets; i++)
	{
	    var angle_offset = (i - half) * _firing_angle_offset;

	    create_bullet(
	        _bullet_type,
	        _gun_barrel_x,
	        _gun_barrel_y,
			_firing_angle + angle_offset
	    );
		
	}
	
}



function create_bullet( 
_bullet_type,
_x_coord, 
_y_coord,
_firing_angle

)
{
	
	// Prevent trying to use a non-existent creator
    //if (!instance_exists(_bullet_type.creator)) return;
	
	var bullets = instance_create_layer(
    _x_coord,
    _y_coord,
    layer,
    obj_bullets,
	{
        creator:		_bullet_type.creator,
        bullet_type:	_bullet_type,
        bullet_damage:	_bullet_type.bullet_damage,
		direction:		_firing_angle,
		image_angle:    _firing_angle,
		speed:			_bullet_type.bullet_speed,
		bullet_sprite:	_bullet_type.sprite
		}
		
	);
	show_debug_message(_firing_angle);
	
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

function calculate_damage(_target, _damage_amount) {

	var shield_damage = _damage_amount;
	
	if (_target == obj_player_functions) {
			shield_damage = _damage_amount / _target.max_shield_modifier;
	}
	
	var health_damage = _damage_amount;
	var shield_rollover = 0;
	
	if (_target.current_shields > 0) {
		shield_rollover = max(0,shield_damage - _target.current_shields);
		health_damage = _damage_amount * _target.shield_absorb_rate + shield_rollover;
	}
	
	else
	health_damage = _damage_amount;
	
	_target.current_shields = max(0, _target.current_shields - shield_damage);
	_target.current_hp -= health_damage;
	_target.shield_recharge_cooldown = _target.max_shield_recharge_cooldown;
	

}


/// @function Change_Position_Of_Object_Origin
/// @description changes the origin of an object to be equal to the mouse X and Y coordinates if "grabbed"
/// @param 
/// @param 
/// @returns void

function Change_Position_Of_Object_Origin()
{
	if (position_meeting(mouse_x, mouse_y, test_object2))
	{
	    if (mouse_check_button_pressed(mb_left))
	    {
        
	        var dx = mouse_x - x;
	        var dy = mouse_y - y;
        
	        var dist = point_distance(0, 0, dx, dy);
	        var dir  = point_direction(0, 0, dx, dy);
        
	        var local_dir = dir - image_angle;

	        var local_x = lengthdir_x(dist, local_dir);
	        var local_y = lengthdir_y(dist, local_dir);
        
	        var offset_x = local_x + sprite_xoffset;
	        var offset_y = local_y + sprite_yoffset;

	        sprite_set_offset(sprite_index, offset_x, offset_y);

	        x = mouse_x;
	        y = mouse_y;
	    }
	}
}












