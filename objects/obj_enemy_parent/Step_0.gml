
if (instance_exists(obj_player_functions))
{
	if (current_hp == starting_hp) health_state = ENEMY_HEALTH_STATE.HIGH;
	if (current_hp < starting_hp && current_hp >= (starting_hp * 0.9)) health_state = ENEMY_HEALTH_STATE.HIGH;
	if (current_hp <= starting_hp * 0.75 && current_hp <= starting_hp * 0.50) health_state = ENEMY_HEALTH_STATE.MED;
	if (current_hp <= starting_hp * 0.50 && current_hp <= starting_hp * 0.25) health_state = ENEMY_HEALTH_STATE.LOW;
	if (current_hp <= starting_hp * 0.25 && current_hp < starting_hp * 0.10) health_state = ENEMY_HEALTH_STATE.CRITICAL;
	if (current_hp <= 0) health_state = ENEMY_HEALTH_STATE.DEAD;
	if (explode_anim >= (sprite_get_number(explode_sprite) - 1)) health_state = ENEMY_HEALTH_STATE.DESTROYED;


	switch (health_state)
	{
		case ENEMY_HEALTH_STATE.MAX:
		{
			damage = base_damage;
			break;
		}
		case ENEMY_HEALTH_STATE.HIGH:
		{
			damage = base_damage * 1.05;
			break;
		}
		case ENEMY_HEALTH_STATE.MED:
		{
			damage = base_damage * 1.1;
			break;
		}
		case ENEMY_HEALTH_STATE.LOW:
		{
			damage = base_damage * 1.1 * 1.1;
			break;
		}
		case ENEMY_HEALTH_STATE.CRITICAL:
		{
			damage = base_damage * 1.1 * 1.1 * 1.25;
			break;
		}
		case ENEMY_HEALTH_STATE.DEAD:
		{
			camera_shake();
			break;
		}
		case ENEMY_HEALTH_STATE.DESTROYED:
		{
			global.shaking = false;
			give_player_xp(1,0);
			instance_destroy();
			break;
		}
	}

	sight_cone = get_sight_cone(x,y,60,400,rotation_angle);
	spotted_player = point_in_triangle(
	obj_player_collision.x,
	obj_player_collision.y,
	x,
	y,
	sight_cone[0],
	sight_cone[1],
	sight_cone[2],
	sight_cone[3]);

	get_list_of_nearest_allies();
	var move_away = move_away_from_ally(min_distance_to_ally);

	//pathfinding
	pathfinding --;
	player_current_x = obj_player_collision.x;
	player_current_y = obj_player_collision.y;

	var sight_line = collision_line(x,y,player_current_x,player_current_y,obj_obstacle,false,true);

	switch (shooting_state)
	{
		case SHOOTING_STATE.SHOOTING_IDLE:
		{
				
			shooting_cooldown_timer = 240;


			if (spotted_player && sight_line == noone)
			{
				shooting_state = SHOOTING_STATE.PREPARING_TO_SHOOT;
			}
		
			break;
		}
	
		case SHOOTING_STATE.PREPARING_TO_SHOOT:
		{

			preparing_to_shoot_timer --;
			if (!spotted_player || sight_line != noone)
			{
				shooting_state = SHOOTING_STATE.SHOOTING_IDLE	
			}
		
			if (preparing_to_shoot_timer <= 0)
			{
				shooting_state = SHOOTING_STATE.SHOOTING;
			}
		
			break;
		}

		case SHOOTING_STATE.SHOOTING:
		{
			find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);

			firing_speed --;
			if (firing_speed <=0) firing_speed = firing_speed_cooldown;

			preparing_to_shoot_timer = gun_cooldown;
			shooting_time --;
			if (health_state != ENEMY_HEALTH_STATE.DEAD || health_state != ENEMY_HEALTH_STATE.DESTROYED)
			{
				if (firing_speed == 1) shoot_bullets(
				enemy_bullets.default_bullet_type, 
				gun_barrels[0],
				gun_barrels[1],
				1,
				rotation_angle,
				0
				);
					
				if (firing_speed = round(firing_speed_cooldown / 2)) shoot_bullets(
				enemy_bullets.default_bullet_type, 
				gun_barrels[2],
				gun_barrels[3],
				1,
				rotation_angle,
				0
				);
			}
			if (shooting_time <= 0)
			{
				shooting_state = SHOOTING_STATE.SHOOTING_COOLDOWN;	
			}
		
			break;
		}
	
		case SHOOTING_STATE.SHOOTING_COOLDOWN:
		{
			shooting_time = shooting_time_reset;

			shooting_cooldown_timer --;
			if (shooting_cooldown_timer <= 0)
			{
				shooting_state = SHOOTING_STATE.SHOOTING_IDLE;	
			}
		
		}
	
	}

	if (shooting_state != SHOOTING_STATE.SHOOTING)
	{
		if (pathfinding <= 0)
		{
			if (shooting_state != SHOOTING_STATE.SHOOTING)
			{
				if (instance_exists(obj_player_functions)) {}
				//chase_player(player_current_x,player_current_y,player_moved,created, move_away.px-x, move_away.py-y);
				else
				{
					if(path_exists(path)) path_delete(path);
					chase_player(xstart,ystart,true,created, move_away.px-x, move_away.py-y);
				}
			}

			created = false;
			pathfinding = irandom_range(pathfinding_cooldown / 2, pathfinding_cooldown);
		}
	}

	else 
	{
		if(path_exists(path)) path_delete(path);
	}


	if (previous_x != x || previous_y != y) 
	{
	    moving = true;
	} 
	else 
	{
	    moving = false;
	}

	previous_x = x;
	previous_y = y;

	pathfinding_timer -= global.delta_multiplier;

	//movement animation
	var next_x = path_get_x(path, 1); // Get the next node's X position
	var next_y = path_get_y(path, 1); // Get the next node's Y position
	var travel_angle = point_direction(x, y, next_x, next_y);
	var angle_diff = angle_difference(image_angle, travel_angle);

	if (moving == true)
	{
		image_speed = 0.8;
	
	    //face toward the next node instead of the player
		image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);
	}
	else
	{
		image_speed = 0;
	}

	//movement behavior

	//choose the angle at which the torso points
	rotation_angle -= choose_torso_angle(prediction_multiplier);

	player_previous_x = obj_player_collision.x;
	player_previous_y = obj_player_collision.y;


	player_moved = ((player_current_x != previous_player_x) || (player_current_y != previous_player_y));

	previous_player_x = obj_player_collision.x;
	previous_player_y = obj_player_collision.y;

	var hit_player = (instance_place(x,y, obj_player_functions))
	{
		if (hit_player == obj_player_functions.id)
		{
			if (explode_anim == 0) cause_damage(hit_player, 10);
			health_state = ENEMY_HEALTH_STATE.DEAD;
		}
	}
	
}

else 
{
	if(path_exists(path)) path_delete(path);
} 

