creator = noone;
rotation = 0;
speed = 0;
image_index = 0;

life_time = 150;
activate_timer = 40;
image_size = 0.25;
image_xscale = image_size;
image_yscale = image_size;

//image_speed = 0;
image_index = 0;

active = false;
launch_speed = random_range(1,2);
turn_radius = 2;
speed = launch_speed;

if (instance_exists(obj_wall_parent))
{
	target = instance_nearest(x,y, obj_wall_parent);
}

alive = true;
explode_anim = 0;
damage = 10;
hit = false;


bullet_types = {
    autocannon: create_bullet_types("Autocannon", 1,  8,  -1,  spr_player_bullet_cannon),
    shotgun:    create_bullet_types("Shotgun",    1,  8,  -1,  spr_player_bullet_shot),
    grenade:    create_bullet_types("Grenade",    5,  5,  -1,  spr_player_bullet_grenade),
    laser:      create_bullet_types("Laser",      10, 6,  -1,  spr_player_bullet_laser),
    blaster:    create_bullet_types("Blaster",    2,  6,  -1,  spr_player_bullet_blaster),
    flamer:     create_bullet_types("Flamer",     1,  4,  20,  spr_player_bullet_flame),
	rocket:     create_bullet_types("Rocket",     1,  4,  -1,  spr_player_rocket),
};

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


