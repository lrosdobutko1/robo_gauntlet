
sight_line_length = get_sight_line(x,y, rotation_angle+90,obj_obstacle);
sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);
spotted = point_in_triangle(obj_player_legs.x,obj_player_legs.y,x,y,sight_cone[0],sight_cone[1],sight_cone[2],sight_cone[3]);
show_debug_message(sight_line_length);
if (spotted)
{
	last_known_player_x = obj_player_legs.x;
	last_known_player_y = obj_player_legs.y;
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

//make a list of all allies, and check to see which is closest
ds_list_clear(ally_list);
current_list_size = 0;
nearest_ally = noone;
min_dist = 999999; // Start with a large number


with (obj_enemy_parent) 
{
    if (id != other.id) 
    {
        ds_list_add(other.ally_list, id);
    }
}

current_list_size = ds_list_size(ally_list);

//only check if the list size has changed
if (current_list_size != previous_list_size) 
{
    for (var i = 0; i < ds_list_size(ally_list); i++) 
    {
        var output = ds_list_find_value(ally_list, i);
    }
}

for (var i = 0; i < ds_list_find_value(ally_list, i); i ++)
{
		var ally_id = ds_list_find_value(ally_list, i);
		var ally_instance = instance_exists(ally_id) ? ally_id : noone;
		
		if (ally_instance != noone)
		{
			var dist = point_distance(x,y, ally_instance.x, ally_instance.y);
			if (dist < min_dist)
			{
				min_dist = dist;
				nearest_ally = ally_instance;
			}
		}
}

previous_list_size = current_list_size;

//check the nearest ally, and plot a vector away from that ally
if (nearest_ally != noone) 
{
    distance = point_distance(x, y, nearest_ally.x, nearest_ally.y);
    dir_away = point_direction(x, y, nearest_ally.x, nearest_ally.y) + 180;

    line_length = clamp(min_distance_to_ally - distance, 0, min_distance_to_ally);

    point_x = x + lengthdir_x(line_length, dir_away);
    point_y = y + lengthdir_y(line_length, dir_away);
}

/* path finding */
if (spotted)
{
//	if (pathfinding_timer <= 0)
//	{
//	    var player_moved = (player_previous_x != obj_player_legs.x || player_previous_y != obj_player_legs.y);

//	    if (initial_path || player_moved)
//	    {
//			//while far from the player
//	        if (distance_to_object(obj_player_legs) >= 104)
//	        {
//	            var change_target_x = obj_player_legs.x + irandom_range(-50, 50);
//	            var change_target_y = obj_player_legs.y + irandom_range(-50, 50);

//	            while (!mp_grid_path(global.grid, path, x, y, change_target_x, change_target_y, true))
//	            {
//	                change_target_x = obj_player_torso.x + irandom_range(-50, 50);
//	                change_target_y = obj_player_torso.y + irandom_range(-50, 50);
//	            }

//	            target_x = change_target_x;
//	            target_y = change_target_y;
//	        }
//	        else
//	        {
//	            target_x = last_known_player_x;
//	            target_y = last_known_player_y;
//	        }

//	        //delete and create a new path only when updating
//	        path_delete(path);
//	        path = path_add();

//	        mp_grid_path(global.grid, path, x, y, target_x, target_y, true);
//			path_start(path, walk_speed * global.delta_multiplier, path_action_stop, true);
//	    }
	
//		//once the player is near
//		if (distance_to_object(obj_player_legs) < 104)
//	    {
//	        target_x = obj_player_torso.x;
//	        target_y = obj_player_torso.y;
//	    }

//	    //delete and create a new path only when updating
//	    path_delete(path);
//	    path = path_add();

//	    mp_grid_path(global.grid, path, x, y, target_x, target_y, true);
//		  path_start(path, walk_speed * global.delta_multiplier, path_action_stop, true);
	
//	    //update previous position only after pathfinding check
//	    player_previous_x = obj_player_legs.x;
//	    player_previous_y = obj_player_legs.y;

//	    pathfinding_timer = irandom_range(pathfinding_cooldown / 2, pathfinding_cooldown);
//		initial_path = false;
//	}
}

//movement animation
var next_x = path_get_x(path, 1); // Get the next node's X position
var next_y = path_get_y(path, 1); // Get the next node's Y position
var travel_angle = point_direction(x, y, next_x, next_y);
var angle_diff = angle_difference(image_angle+90, travel_angle);

if (moving == true)
{
	image_speed = 0.8;
	
    //face toward the next node instead of the player
    //image_angle = travel_angle;
	image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);
}
else
{
	image_speed = 0;
}

//destroyed
if (hp <= 0) alive = false;
if (!alive)
{
	instance_create_layer(x,y,"explosions",obj_explosions);
	instance_create_layer(x,y,"scorch_marks",obj_scorch_mark);
	instance_destroy();
}

