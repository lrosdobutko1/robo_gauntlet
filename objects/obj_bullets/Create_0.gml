creator = noone;

speed = 0;
image_index = 0;
function create_bullet_types(_name, _damage, _sprite){
	return {
		bullet_name: _name,
		damage: _damage,
		sprite: _sprite
	};
}

bullet_types = {
	autocannon: create_bullet_types("Autocannon", 1, spr_player_bullet_cannon),	
	shotgun: create_bullet_types("Shotgun", 1, spr_player_bullet_shot),
	grenade: create_bullet_types("Grenade", 5, spr_player_bullet_grenade),
	laser: create_bullet_types("Laser", 10, spr_player_bullet_laser),
	blaster: create_bullet_types("Blaster", 2, spr_player_bullet_blaster),
	flamer: create_bullet_types("Flamer", 1, spr_player_bullet_flame),
};

current_bullet_type = undefined;

