

//destroy bullets when their timer expires
if (life_timer > -1) {
	life_timer --;
	if life_timer <- 0 instance_destroy();
}

// destroy bullets if they get too far out of the room.
var px = creator.x;
var py = creator.y;
if (abs(x - px) > room_width/2 || abs(y - py) > room_height/2) {
	instance_destroy();
}

switch (current_bullet_type.bullet_name) {
	case "Autocannon": {

		break;
	}
	
	case "Shotgun": {
		show_debug_message("shotgun");
		break;
	}
		
	case "Grenade": {
		speed += 0.1;
		if (speed >= 5) speed = 5;
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
		image_scale +=0.05;
		if (image_scale >= 1) image_scale = 1;
		hspeed = h_speed + obj_player_collision.h_speed;
		vspeed = v_speed + obj_player_collision.v_speed;
		image_xscale = image_scale;
		image_yscale = image_scale;
		image_angle = random(359);

		break;
	}
		
	case "Rocket": {
		if (rockets_launching) rockets_launching_timer --;
	
		if (rockets_launching_timer <= 0) { 
			rockets_launching = false;
			turn_radius = 5;
			rockets_launching_timer = 20;
		}
	
		image_speed = 1;
		direction = image_angle;
	
		//smoke trails
		instance_create_layer(x,y,layer,obj_rocket_smoke);
	
		//targeting
		if (point_distance(x, y, rocket_target_x, rocket_target_y) < 50) {
	
			if (instance_exists(obj_enemy_parent))
			{
			
				target = instance_nearest(rocket_target_x,rocket_target_y, obj_enemy_parent);
				rocket_target_x = target.x;
				rocket_target_y = target.y;
			}
	
		}

		if (has_target) {
			var angle_diff = angle_difference(image_angle, point_direction(x,y,rocket_target_x,rocket_target_y));
			image_angle -= min(abs(angle_diff), turn_radius) * sign(angle_diff);
			if (turn_radius >=40) turn_radius = 40;
		}
	
		turn_radius += 0.02;
		image_xscale = image_scale;
		image_yscale = image_scale;
		break;
	}
	
	case "Shell Casing": {
	
		if (obj_player_functions.current_primary_weapon.weapon_name == "Flamethrower") {
			hspeed = h_speed + obj_player_collision.h_speed;
			vspeed = v_speed + obj_player_collision.v_speed;
			image_index = 1;
			image_scale += 0.1;
			image_xscale = image_scale;
			image_yscale = image_scale;
			life_timer --;
		}
		else {
			image_index = 0;
			image_xscale = 0.5;
			image_yscale = 0.5;
		}
	
		speed -= 0.05;
		image_speed = 0;
		if (speed <= 0) speed = 0;

		break;		
	}
}

#region Collision with walls

var hit_wall = resolve_x_collision(hspeed, obj_obstacle)

if (hit_wall == noone) hit_wall = resolve_y_collision(vspeed, obj_obstacle)
if (hit_wall != noone) instance_destroy();

#endregion

#region collision with enemies

var hit_enemy = resolve_x_collision(hspeed, enemy);

if (hit_enemy == noone) hit_enemy = resolve_y_collision(vspeed, enemy);


if (hit_enemy != noone) {
	
	if (current_bullet_type.bullet_name != "Flamer")
	{
		calculate_damage(hit_enemy, current_bullet_type.bullet_damage)
	    instance_destroy();
	}
	else
	{
	    collision_timer--;
	    if (collision_timer <= 0) instance_destroy();
	}
}
	

#endregion







