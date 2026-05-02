// Inherit the parent event
event_inherited();

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
			mask_index = -1;
			break;
		}
		case ENEMY_HEALTH_STATE.DESTROYED:
		{
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

	//pathfinding
	player_current_x = obj_player_collision.x;
	player_current_y = obj_player_collision.y;

	var sight_line = collision_line(x,y,player_current_x,player_current_y,obj_obstacle,false,true);

	if (pathfinding_timer <= 0) { 
		if (player_moved) update_pathfinding = true;
			pathfinding_timer = irandom_range(pathfinding_cooldown/2, pathfinding_cooldown*1.5);
		}
	else update_pathfinding = false;
		
	chase_the_player(update_pathfinding)

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

	//movement animation
	var next_x = path_get_x(path, 1); // Get the next node's X position
	var next_y = path_get_y(path, 1); // Get the next node's Y position
	var travel_angle = point_direction(x, y, next_x, next_y);
	var angle_diff = angle_difference(legs_angle, travel_angle);
	
	if (moving)
	{
		image_speed = 0.8;
		leg_anim += 0.20;
		if leg_anim >= sprite_get_number(spr_basic_gunner_legs) leg_anim = 0;
	
	    //face toward the next node instead of the player
		legs_angle -= min(abs(angle_diff), 5) * sign(angle_diff);
	}
	else
	{
		image_speed = 0;
	}

	//movement behavior

	//choose the angle at which the torso points
	rotation_angle -= choose_torso_angle(prediction_multiplier);

	player_moved = ((player_current_x != previous_player_x) || (player_current_y != previous_player_y));

	previous_player_x = obj_player_collision.x;
	previous_player_y = obj_player_collision.y;

	var hit_player = (instance_place(x,y, obj_player_functions))
	{
		if (hit_player == obj_player_functions.id)
		{
			if (explode_anim == 0) calculate_damage(hit_player, 40);
			health_state = ENEMY_HEALTH_STATE.DEAD;
		}
	}
	
	pathfinding_timer -= global.delta_multiplier;
}

if (!instance_exists(player)) {
	moving = false;
	if(path_exists(path)) path_delete(path);
	
}

