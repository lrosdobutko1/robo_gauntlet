
level = 1;

experience_points = 0;
enemy_kills = 0;

base_hp = 40;
max_hp = (base_hp * level) + power(level,level);
current_hp = max_hp;

base_shields = 20 + level;
max_shields = (base_shields + max_hp/2);
current_shields = max_shields;
shield_absorb_rate = 0.25 + level*0.03;
shield_recharge_rate = 0.005;
max_shield_recharge_cooldown = 240;
shield_recharge_cooldown = 0;

enum PLAYER_HEALTH_STATE
{
	FULL,
	HIGH,
	MED,
	LOW,
	CRITICAL,
	DEAD,
	DESTROYED
}

health_state = PLAYER_HEALTH_STATE.FULL;
explode_anim = 0;

explosion_sprites = [spr_explode1, spr_explode2];
explode_sprite = explosion_sprites[irandom(array_length(explosion_sprites)-1)];

image_scale = 1;

image_speed = 1;
image_xscale = image_scale;
image_yscale = image_scale;
flash = 0;

#region	movement and animation
rotation_angle = point_direction(x,y,mouse_x,mouse_y);
leg_angle = 0;
leg_anim = 0;

moving = false;

h_speed = 0;
v_speed = 0;

walk_speed = 2;

//x = obj_player_collision.x;
//y = obj_player_collision.y;
#endregion



#region Player Weapon Selection code
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
    _weapon_level, 
    _num_bullets, 
    _firing_speed, 
    _speed_offset, 
    _bullet_angle, 
    _bullet_type,
    _weapon_sprite
) {
    return {
        weapon_name:            _weapon_name,
        base_damage:          _base_dmg,
        weapon_level:           _weapon_level,
        num_bullets:            _num_bullets,
        firing_speed:           _firing_speed,
        firing_speed_offset:    _speed_offset,
        bullet_angle:           _bullet_angle,
        bullet_type:            _bullet_type,
        weapon_sprite:          _weapon_sprite
    };
}

// _creator, _name, _bullet_damage, _speed, _timer, _sprite
bullet_types = {
    autocannon:   create_bullet_types(id, "Autocannon",   1,   6,   -1,  spr_player_bullet_cannon),
    shotgun:      create_bullet_types(id, "Shotgun",      2,   8,   -1,  spr_player_bullet_shot),
    grenade:      create_bullet_types(id, "Grenade",      4,  .5,   -1,  spr_player_bullet_grenade),
    laser:        create_bullet_types(id, "Laser",        1,   6,   -1,  spr_player_bullet_laser),
    blaster:      create_bullet_types(id, "Blaster",      2,   6,   -1,  spr_player_bullet_blaster),
    flamer:       create_bullet_types(id, "Flamer",       0.5, 4,   15,  spr_player_bullet_flame),
	rocket:		  create_bullet_types(id, "Rocket",       5,   6,   400, spr_player_rocket),
	//muzzle_flash: create_bullet_types(id, "Muzzle Flash", 0,   0,    3,  spr_muzzle_flash),
	shell_casing: create_bullet_types(id, "Shell Casing", 0,   1,   -1,  spr_bullet_casing),
};


player_weapons = {
    autocannon: weapon_base("AutoCannon",	1, 1, 1, 20,  0.5, 0, bullet_types.autocannon, spr_player_guns_autocannon),
    shotgun:    weapon_base("Shotgun",		1, 1, 3, 120, 1, 9,   bullet_types.shotgun,    spr_player_guns_shotgun),
    grenade:    weapon_base("Grenades",		5, 1, 1, 160, 0.5, 0, bullet_types.grenade,    spr_player_guns_grenade),
    laser:      weapon_base("Laser",		5, 1, 1, 1,   1, 0,   bullet_types.laser,      spr_player_guns_laser),
    blaster:    weapon_base("Blaster",		5, 1, 1, 50,  1, 0,   bullet_types.blaster,    spr_player_guns_blaster),
    flamer:     weapon_base("Flamethrower",	5, 1, 1, 2,   1, 0,   bullet_types.flamer,     spr_player_guns_flamer),
	rockets:	weapon_base("Rockets",		1, 1, 1, 20,  0.5, 0, bullet_types.rocket,	   spr_player_rocket)
};

primary_weapon_slots = [
    noone, // index 0 unused
    player_weapons.autocannon,
    player_weapons.shotgun,
    player_weapons.grenade,
    player_weapons.laser,
    player_weapons.blaster,
    player_weapons.flamer
];


//*****replace current_primary_weapon later*****//
current_primary_weapon = primary_weapon_slots[1];
current_secondary_weapon = player_weapons.rockets;

max_rockets = 12;
rocket_counter = max_rockets;
#endregion


if (instance_exists(obj_player_gui)) {
	max_weapon_modifier = 1.5 - (obj_player_gui.p_t_w_line_length / obj_player_gui.max_p_t_line_length);
	max_shield_modifier = 1.5 - (obj_player_gui.p_t_s_line_length / obj_player_gui.max_p_t_line_length);
	max_engine_modifier = 1.5 - (obj_player_gui.p_t_e_line_length / obj_player_gui.max_p_t_line_length);
}

damage_scale_modifier = 1 + (level * 0.5);

gun_anim = 0;

gun_select_keys = 0;

firing = false;
firing_rockets = false;

firing_angle = image_angle;
can_animate_guns = true;
anim_guns_counter = current_primary_weapon.firing_speed;
weapon_anim_frame_number = 0;

firing_speed_cooldown = current_primary_weapon.firing_speed;

player_rocket_cooldown = 480;
player_rocket_timer = player_rocket_cooldown;
rockets_ready = true;

rocket_offset_cd = 60;
rocket_offset = rocket_offset_cd;

gun_barrels = array_create(4);
casings_eject = array_create(4);
rocket_launchers = array_create(4);

muzzle_flash_counters = round(current_primary_weapon.firing_speed/3);
draw_muzzle_flash_left  = false;
draw_muzzle_flash_left_counter = muzzle_flash_counters;

draw_muzzle_flash_right = false;
draw_muzzle_flash_right_counter = muzzle_flash_counters;

muzzle_flash_frame = 0;

can_shoot = false;











