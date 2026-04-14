/* Default Variable definitions are:
creator,
bullet_type,
firing_angle,
bullet_damage,
bullet_sprite
*/


step_counter = 0;
sprite_index = bullet_sprite;

life_timer = bullet_type.life_timer;

h_speed = hspeed;
v_speed = vspeed;
image_scale = 0;

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

switch (current_bullet_type.bullet_name) {
	
	case "Autocannon": {
		h_speed = hspeed;
		v_speed = vspeed;
		show_debug_message("autocannon");
		break;
	}
	
	case "Shotgun": {
		show_debug_message("shotgun");
		break;
	}

	case "Grenade": {
		show_debug_message("autocannon");
		break;
	}
	
	case "Laser": {
		show_debug_message("shotgun");
		break;
	}
		
	case "Blaster": {
		show_debug_message("autocannon"); 
		break;
}
	
	case "Flamer": {
		image_speed = 0;
		image_index = 5;
		image_scale = .25;
		image_xscale = image_scale;
		image_yscale = image_scale;
		collision_timer = 3;
	
		break;
	}
		
	case "Rocket": {
		has_target = true;
		rockets_launching = true;
		rockets_launching_timer = 20;
		rocket_target_range = 200;
		rocket_target_x = obj_player_functions.x + lengthdir_x(rocket_target_range,obj_player_functions.rotation_angle + irandom_range(-5,5));
		rocket_target_y = obj_player_functions.y + lengthdir_y(rocket_target_range,obj_player_functions.rotation_angle + irandom_range(-5,5));
		turn_radius = 20;
		image_scale = 0.3;
		//image_angle -= 90 + random_range(-45,45);
		image_xscale = image_scale;
		image_yscale = image_scale;
		break;
	}
	
	case "Shell Casing": {
		if (obj_player_functions.current_primary_weapon.weapon_name == "Flamethrower") {
			h_speed = hspeed;
			v_speed = vspeed;
			image_index = 1;	
			image_scale = 1
			life_timer = 40;
		}
		else image_index = 0;
	
			speed += random_range(-1,1);
			break;		
	}
}

function resolve_x_collision(_dy, _obj)
{
    if (_dy == 0) return noone;

    return instance_place(x + _dy, y , _obj);
}

function resolve_y_collision(_dy, _obj)
{
    if (_dy == 0) return noone;

    return instance_place(x, y + _dy, _obj);
}

