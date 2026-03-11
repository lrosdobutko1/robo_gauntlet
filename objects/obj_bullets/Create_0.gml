//speed = 0;
//image_index = 0;

//life_time = 150;
//activate_timer = 40;
//image_size = 0.25;
//image_xscale = 1;
//image_yscale = 1;

////image_speed = 0;
//image_index = 0;

//active = false;
//launch_speed = random_range(1,2);
//turn_radius = 2;
//speed = launch_speed;

//if (instance_exists(obj_wall_parent))
//{
//	target = instance_nearest(x,y, obj_wall_parent);
//}

//alive = true;
//explode_anim = 0;
//damage = 10;
//hit = false;

enemy = (creator.object_index == obj_player_functions) ? obj_enemy_parent : obj_player_functions;

enemy_default = {
    default_bullet: create_bullet_types("Default", 1, 8, -1, spr_player_bullet_cannon),
	}

function resolve_x_collision(_dx, _obj)
{
    if (_dx == 0) return false;

    return instance_place(x + _dx, y, _obj);
}

function resolve_y_collision(_dy, _obj)
{
    if (_dy == 0) return false;

    return instance_place(x, y + _dy, _obj);
}


collision_timer = 6;

// Resolve bullet type (enemy vs player)
if (creator != obj_player_functions.id) {
    current_bullet_type = enemy_default.default_bullet;
	bullet_scale = 0.5
	image_xscale = bullet_scale;
	image_yscale = bullet_scale;
} else {
    current_bullet_type = bullet_type;
}

// Set direction and appearance
direction    = creator.rotation_angle + angle_offset;
image_angle  = creator.rotation_angle + angle_offset;
sprite_index = current_bullet_type.sprite;
life_timer   = current_bullet_type.life_timer;
speed        = current_bullet_type.bullet_speed;

// Rotation for flamer
if (current_bullet_type.bullet_name == "Flamer") {
    rotation = random(359);
} else {
    rotation = 0;
}




