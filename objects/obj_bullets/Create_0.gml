/* Default Variable definitions are:
creator,
bullet_type,
firing_angle,
bullet_damage,
bullet_sprite
*/





////speed = 0;
////image_index = 0;

//life_time = 150;
//activate_timer = 40;
////image_size = 0.25;
////image_xscale = 1;
////image_yscale = 1;

//////image_speed = 0;
////image_index = 0;

//active = false;
//launch_speed = random_range(1,2);
//turn_radius = 2;
////speed = launch_speed;

//if (instance_exists(obj_enemy_parent))
//{
//	target = instance_nearest(x,y, obj_enemy_parent);
//}
//else target = noone;

//alive = true;
//explode_anim = 0;
//damage = 10;
//hit = false;

life_timer = bullet_type.life_timer;
collision_timer = 6;

enemy = (creator.object_index == obj_player_functions) ? obj_enemy_parent : obj_player_functions;

enemy_bullets = {
    default_bullet: create_bullet_types(id, "Default", 1, 8, -1, spr_player_bullet_cannon),
	}

// Resolve bullet type (enemy vs player)
if (creator != obj_player_functions.id) {
    current_bullet_type = enemy_bullets.default_bullet;
	bullet_scale = 0.5
	image_xscale = bullet_scale;
	image_yscale = bullet_scale;
} else {
    current_bullet_type = bullet_type;
}


function resolve_x_collision(_dx, _obj)
{
    if (_dx == 0) return noone;

	while (instance_place(x +_dx, y, _obj) == noone)
    return instance_place(x + _dx, y, _obj);
}

function resolve_y_collision(_dy, _obj)
{
    if (_dy == 0) return noone;

    return instance_place(x, y + _dy, _obj);
}


