sprites = [
    spr_power_up_a,
    spr_power_up_b,
    spr_power_up_f,
    spr_power_up_g,
    spr_power_up_l,
    spr_power_up_s,
    spr_power_up_armor,
    spr_power_up_energy
];

sprite_index = sprites[irandom(array_length(sprites)-1)];
image_index = irandom(image_number);
image_speed = 1;


function random_normal(_mean, _stdev) {
    var r1 = random(1);
    var r2 = random(1);

    var z = sqrt(-2 * ln(u1)) * cos(2 * pi * u2);

    return  round(_mean + z * _stdev);
}

//i_level determined by the level of the monster dropping the item.
var i_level = clamp (elevel - random_normal(0, stddev), 0, elevel);

//q_level determined by player level +/- 3
var q_level = clamp(clevel - random_normal(0, stddev), 0, clevel + irandom_range(-3,3) );


// affix level is a formula to determine the final "quality" value of the item that dropped and should
// correspond to a table of values
var affix_level = max( round(q_level/2), i_level - floor(0.75*q_level));

debug = $"quality level: {q_level}, item level: {i_level}, affix level: {affix_level}";
show_debug_message( debug );


function create_loot(_enemy_level, _player_level) {
	
	var random_clevel_mod = irandom_range(-3,3);
	var stddev = 6;
	
	
//i_level determined by the level of the monster dropping the item.
var i_level = clamp (_enemy_level - random_normal(0, stddev), 0, _enemy_level);

//q_level determined by player level +/- 3
var q_level = clamp(_player_level - random_normal(0, stddev), 0, _player_level + irandom_range(-3,3) );


// affix level is a formula to determine the final "quality" value of the item that dropped and should
// correspond to a table of values
var affix_level = max( round(q_level/2), i_level - floor(0.75*q_level));

	

	//randomly choose a weapon(1), armor(2), energy(>2)
	var loot_type = irandom(5);
	if (loot_type ==1) {
			
	}
	
}


/// @function weapon_base
/// @description Creates a base weapon definition.
/// @param {string} _name Weapon display name
/// @param {real}   _dmg Base damage per bullet
/// @param {real}   _level level modifier for bullet damage and firing speed
/// @param {real}   num_bullets Number of bullets fired
/// @param {real}   firing_speed Frames between shots
/// @param {real}   firing_speed_offset offsets left and right guns
/// @param {real}   _bullet_angle Spread angle in degrees
/// @param {struct}   _bullet_type Type of bullet to be fired
/// @param {asset}  _sprite Projectile sprite
/// @returns {struct} Weapon base stats struct
function weapon_base(
    _weapon_name, 
    _base_dmg, 
    _i_level, 
    _num_bullets, 
    _firing_speed, 
    _speed_offset, 
    _bullet_angle, 
    _bullet_type,
    _weapon_sprite
) {
    return {
        weapon_name:            _weapon_name,
        base_damage:			_base_dmg,
        weapon_level:           _i_level,
        num_bullets:            _num_bullets,
        firing_speed:           _firing_speed,
        firing_speed_offset:    _speed_offset,
        bullet_angle:           _bullet_angle,
        bullet_type:            _bullet_type,
        weapon_sprite:          _weapon_sprite
    };
}

weapon_types = {
    autocannon: weapon_base("AutoCannon",	1, 1, 1, 20,  0.5, 0, bullet_types.autocannon, spr_player_guns_autocannon),
    shotgun:    weapon_base("Shotgun",		1, 1, 3, 60, 1, 9,   bullet_types.shotgun,    spr_player_guns_shotgun),
    grenade:    weapon_base("Grenades",		5, 1, 1, 160, 0.5, 0, bullet_types.grenade,    spr_player_guns_grenade),
    laser:      weapon_base("Laser",		5, 1, 1, 1,   1, 0,   bullet_types.laser,      spr_player_guns_laser),
    blaster:    weapon_base("Blaster",		5, 1, 1, 50,  1, 0,   bullet_types.blaster,    spr_player_guns_blaster),
    flamer:     weapon_base("Flamethrower",	5, 1, 1, 2,   1, 0,   bullet_types.flamer,     spr_player_guns_flamer),
	rockets:	weapon_base("Rockets",		1, 1, 1, 20,  0.5, 0, bullet_types.rocket,	   spr_player_rocket)
};

powerup_type = { 
    weapon: {
        weapon_name: "",
        i_level: 0,
        num_bullets: 0,
        firing_speed: 0,
		affix: ""
    },
    
    armor: {
        armor_name: "",
        i_level: 0,
        damage_reduction: 0,
        affix: ""
    },
    
    energy: {
		energy_name: "",
		i_level: 0,
        energy_gained: 0
    }
};

