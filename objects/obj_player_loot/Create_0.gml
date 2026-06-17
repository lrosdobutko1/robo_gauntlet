player_collision = obj_player_collision;
player = obj_player_functions;

sprites = [
    spr_power_up_a,
    spr_power_up_b,
    spr_power_up_f,
    spr_power_up_g,
    spr_power_up_l,
    spr_power_up_s,
    spr_power_up_armor,
    spr_power_up_energy,
	spr_power_up_money
];

sprite_index = sprites[irandom(array_length(sprites)-1)];
image_index = irandom(image_number);
image_speed = 1;

c_level = 60;
e_level = 60;
stddev = 15;

function random_normal(_mean, _stdev) {
    var r1 = random(1);
    var r2 = random(1);

    var z = sqrt(-2 * ln(r1)) * cos(2 * pi * r2);

    return  round(_mean + z * _stdev);
}

//i_level determined by the level of the monster dropping the item. q_level determined by player level on a bell curve
i_level = e_level;
q_level = clamp(c_level - random_normal(0, stddev), 0, round(c_level+c_level/10));

function create_power_up_type(
_i_level, 
_q_level, 
_weapon_name, 
_base_dmg,  
_num_bullets, 
_firing_speed, 
_speed_offset, 
_bullet_angle, 
_bullet_type,
_weapon_sprite
) {
	return {
		_i_level, 
		_q_level,
		
		_weapon_name, 
		_base_dmg, 
    
		_num_bullets, 
		_firing_speed, 
		_speed_offset, 
		_bullet_angle, 
		_bullet_type,
		_weapon_sprite
	}
		
}

function create_loot(_enemy_id, _player_id) {
	
	var stddev = 6;
		
	//i_level determined by the level of the monster dropping the item. q_level determined by player level
	var i_level = clamp (_enemy_id.level - random_normal(0, stddev), 0, _enemy_id.level);
	var q_level = clamp(_player_id.level - random_normal(0, stddev), 0, _player_id.level);
	

	
	var powerup_type = { 
    weapon: {
        weapon_name: "",
        item_level: _i_level,
		quality_level: _q_level,
        num_bullets: 0,
        firing_speed: 0,
		affix_1: 0,
		affix_2: 0,
		affix_3: 0
    },
    
    armor: {
        armor_name: "",
        item_level: _i_level,
		quality_level: _q_level,
        damage_reduction: 0,
        affix_1: 0,
		affix_2: 0,
		affix_3: 0
    },
    
    energy: {
		energy_name: "Energy",
		item_level: _i_level,
		quality_level: _q_level,
        energy_gained: 0
    },
	
	money: {
		money_name: "Credits",
		item_level: _i_level,
		quality_level: _q_level
	}
};
	
	//randomly choose a weapon(0), armor(1), energy(>2), money, or nothing.
	var loot_type_value = irandom(1000);
	//nothing drops
	if (loot_type_value > 500) return;
	
	//money
	if (loot_type_value > 300) { 
		
			//loot type is money
			if (place_meeting(x,y, player_collision)) {
				player.money += q_level + irandom(9);
				instance_destroy();
			}

		}
		
	//energy
	else if (loot_type_value >= 100 && loot_type_value <= 300) {
		
		//loot type is energy
		if (place_meeting(x,y, player_collision)) {
			player.current_hp += q_level + irandom(q_level) + irandom(9);
			instance_destroy();
		}
	
	}
	
	// weapons or armor
	else {
		
		
	
		// affix level is a formula to determine the final "quality" value of the item that dropped and should
		// correspond to a table of values
		var affix_level = i_level + floor(q_level * 0.5);
		
		// [min_level, affix_1%, affix_2%, affix_3%]
		affix_chance_table = [
		    { min_level: 0,  a_1: 0,   a_2: 0,   a_3: 0  }, //tier 0
		    { min_level: 1,  a_1: 10,  a_2: 0,   a_3: 0  }, //tier 1
		    { min_level: 11, a_1: 25,  a_2: 10,  a_3: 0  },	//tier 2
		    { min_level: 21, a_1: 50,  a_2: 25,  a_3: 0  },	//tier 3
		    { min_level: 31, a_1: 75,  a_2: 50,  a_3: 25 },	//tier 4
		    { min_level: 41, a_1: 100, a_2: 75,  a_3: 50 },	//tier 5
		    { min_level: 51, a_1: 100, a_2: 100, a_3: 50 }	//tier 6
		];
		
		var affix_1 = false;
		var affix_2 = false;
		var affix_3 = false;

		// find quality tier in the table
		var tier = 0;
		for (var i = 0; i < array_length(affix_table); i++) {
		    if (affix_level >= affix_table[i].min) {
		        tier = i;
		    }
		}

		// apply rolls
		affix_1 = random(100) < affix_table[tier].a1;
		affix_2 = random(100) < affix_table[tier].a2;
		affix_3 = random(100) < affix_table[tier].a3;
		
		var loot_object = { 
			
			}
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



