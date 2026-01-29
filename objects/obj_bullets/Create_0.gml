creator = noone;
rotation = 0;
speed = 0;
image_index = 0;
function create_bullet_types(_name, _damage, _sprite){
	return {
		bullet_name: _name,
		damage: _damage,
		sprite: _sprite
	};
}

//bullet_types = {
//	autocannon: create_bullet_types("Autocannon", 1, spr_player_bullet_cannon),	
//	shotgun: create_bullet_types("Shotgun", 1, spr_player_bullet_shot),
//	grenade: create_bullet_types("Grenade", 5, spr_player_bullet_grenade),
//	laser: create_bullet_types("Laser", 10, spr_player_bullet_laser),
//	blaster: create_bullet_types("Blaster", 2, spr_player_bullet_blaster),
//	flamer: create_bullet_types("Flamer", 1, spr_explode1),
//};

//current_bullet_type = undefined;

function resolve_x_collision(_dx, _obj)
{
    if (_dx == 0) return false;

    return place_meeting(x + _dx, y, _obj);
}

function resolve_y_collision(_dy, _obj)
{
    if (_dy == 0) return false;

    return place_meeting(x, y + _dy, _obj);
}

collision_timer = 6;
