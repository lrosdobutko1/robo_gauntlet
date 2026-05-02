

//destroy bullets when their timer expires
if (life_timer > -1) {
	life_timer --;
	if life_timer <- 0 instance_destroy();
}

// destroy bullets if they get too far out of the room.
if (instance_exists(creator)) {
	px = creator.x;
	py = creator.y;
}

if (abs(x - px) > room_width/2 || abs(y - py) > room_height/2) {
	instance_destroy();
}



switch (current_bullet_type.bullet_name) {
	case "Autocannon": {
		
		
		break;
	}
	
	case "Shotgun": {

		break;
	}
		
	case "Grenade": {
		speed += 0.1;
		if (speed >= 5) speed = 5;
		break;
	}
	
	case "Laser": {

		break;
	}
		
	case "Blaster": {

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
		depth = -10000;
		if (rockets_launching) rockets_launching_timer --;
	
		if (rockets_launching_timer <= 0) { 
			rockets_launching = false;
			has_target = false;
			turn_radius = 2;
			rockets_launching_timer = 20;
		}
	
		image_speed = 1;
		direction = image_angle;
	
		//smoke trails
		if (!exploding) instance_create_layer(x,y,"player_bullets",obj_rocket_smoke);
	
		//targeting
		if (point_distance(x, y, rocket_target_x, rocket_target_y) < 50) {
	
			if (instance_exists(obj_enemy_parent))
			{
				has_target = true;
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
		if (!exploding) {
			image_xscale = image_scale;
			image_yscale = image_scale;
		}
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
		image_angle += rotation_direction;
		rotation_direction -= sign(rotation_direction)*0.02;
		speed -= 0.05;
		image_speed = 0;
		if (speed <= 0) speed = 0;
		if (speed == 0 && rotation_direction == 0) moving = false;

		break;		
	}
}

#region Collision with walls
var hit_wall = resolve_x_collision(hspeed, obj_obstacle)

if (hit_wall == noone) hit_wall = resolve_y_collision(vspeed, obj_obstacle)
if (hit_wall != noone) {
	if (current_bullet_type.bullet_name != "Flamer" && current_bullet_type.bullet_name != "Rocket")
	{
		instance_destroy();
	}
	else if (current_bullet_type.bullet_name == "Rocket")
	{
		ds_list_add(global.explosion_list, self.id);
		exploding = true;
		sprite_index = explosion_sprite;
		speed = 0;
	}
	else
	{
	    collision_timer--;
	    if (collision_timer <= 0) {
			hspeed = 0;
			vspeed = 0;
			instance_destroy(); 
			}
	}	
}


#endregion

#region collision with enemies

var hit_enemy = resolve_x_collision(hspeed, enemy);

if (hit_enemy == noone) hit_enemy = resolve_y_collision(vspeed, enemy);


if (hit_enemy != noone) {
	
	if (current_bullet_type.bullet_name == "Flamer")
	{
		calculate_damage(hit_enemy, current_bullet_type.bullet_damage)
	    collision_timer--;
	    if (collision_timer <= 0) {
			instance_destroy();
			hspeed = 0;
			vspeed = 0;
		}
	}
	else if(current_bullet_type.bullet_name != "Rocket")
	{
		calculate_damage(hit_enemy, current_bullet_type.bullet_damage)
	    instance_destroy();
	}
	else {
		//add self to list of entities calling the shake_camera() function
		exploding = true;
		ds_list_add(global.explosion_list, self.id);
		sprite_index = explosion_sprite;
		
		//find all enemies to do damage to
		collision_circle_list(x, y, aoe_radius, enemy, 0, 1, aoe_damage_list, 0)
		
		for (var i = 0; i < ds_list_size(aoe_damage_list); i++) {
			var damage_scale = 1 - point_distance(
			x, 
			y, 
			ds_list_find_value(aoe_damage_list, i).x, 
			ds_list_find_value(aoe_damage_list, i).y) / aoe_radius;
			calculate_damage(ds_list_find_value(aoe_damage_list, i), ((current_bullet_type.bullet_damage * damage_scale)/2))
			show_debug_message($"{i+1}: {ds_list_find_value(aoe_damage_list, i)} - Took {current_bullet_type.bullet_damage * damage_scale} damage");
		}
		
		calculate_damage(hit_enemy, current_bullet_type.bullet_damage)
		speed = 0;
	}
	
	if (apply_knock_back) {
		show_debug_message("I have knockback");
			
		var _dir = point_direction(x,y, enemy.x, enemy.y)-180;
		var _knock_back_magnitude = -4;
		var _kbx = lengthdir_x(_knock_back_magnitude, _dir);
		var _kby = lengthdir_y(_knock_back_magnitude, _dir);
			
		hit_enemy.x += _kbx;
		hit_enemy.y += _kby;
	}
	
}

if (exploding) {
	image_xscale = 1;
	image_yscale = 1;
	camera_shake();
	
	if (image_index >= image_number -1) {
		//find the number of units causing a camera shake
		var index = ds_list_find_index(global.explosion_list, id);
		if (index != -1)
		{
		    ds_list_delete(global.explosion_list, index);
		}
		
		instance_destroy();
	}
}




#endregion







