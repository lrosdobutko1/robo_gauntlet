
path = path_add();

pathfinding_cooldown = 40;
pathfinding = pathfinding_cooldown;

walk_speed = 0.8;

player_current_x = obj_player_collision.x;
player_current_y = obj_player_collision.y;

previous_player_x = obj_player_collision.x;
previous_player_y = obj_player_collision.y;

player_moved = ((player_current_x != previous_player_x) || (player_current_y != previous_player_y));

created = true;

current_list_size = 0;
nearest_ally = noone;
min_dist = 99999999;

ally_list = ds_list_create();
previous_list_size = 0;

//// drawa a line away from nearby allies
distance = 0;
dir_away = 0;
line_length = 0;

point_x = 0;
point_y = 0;

min_distance_to_ally = 50;


//no longer in use. remove function later
function chase_player(player_current_x, player_current_y, player_moved, created, point_x, point_y) 
{
    //var update_path = false;

    //// Player is close always chase directly
    //if (distance_to_object(obj_player_collision) <= 104)
    //{
    //    target_x = player_current_x;
    //    target_y = player_current_y;
    //    update_path = true;
    //}
    //// Player is far only set new target if player moved or just created
    //else if (created || player_moved)
    //{
    //    var change_target_x = player_current_x + irandom_range(-50, 50);
    //    var change_target_y = player_current_y + irandom_range(-50, 50);

    //    while (!mp_grid_path(global.grid, path, x, y, change_target_x, change_target_y, true))
    //    {
    //        change_target_x = player_current_x + irandom_range(-50, 50);
    //        change_target_y = player_current_y + irandom_range(-50, 50);
    //    }

    //    target_x = change_target_x;
    //    target_y = change_target_y;
    //    update_path = true;
    //}

    //// Only update path if a valid target was selected
    //if (update_path)
    //{
    //    path_delete(path);
    //    path = path_add();

    //    if (mp_grid_path(global.grid, path, x, y, target_x, target_y, true))
	//	{
	//	var point_count = path_get_number(path);

	//	// If path has at least 2 points, we can modify the second point
	//		if (point_count > 1)
	//		{
	//			var dx = path_get_point_x(path, 1);
	//			var dy = path_get_point_y(path, 1);

	//			// Add a random offset
	//			dx += point_x;
	//			dy += point_y;

	//			// Delete and recreate the path using the new offset as target
	//			path_delete(path);
	//			path = path_add();
	//			mp_grid_path(global.grid, path, x, y, dx, dy, true);
	//		}
	//	}
    //    path_start(path, walk_speed, path_action_stop, true);
    //}
}


function basic_chase_player(point_x, point_y, move_speed)
{
	var target_x = obj_player_collision.x;
	var target_y = obj_player_collision.y;

	// Delete the current path and make a fresh one
	path_delete(path);
	path = path_add();

	// Generate an initial path to the player
	if (mp_grid_path(global.grid, path, x, y, target_x, target_y, true))
	{
		var point_count = path_get_number(path);

		// If path has at least 2 points, we can modify the second point
		if (point_count > 1)
		{
			var dx = path_get_point_x(path, 1);
			var dy = path_get_point_y(path, 1);

			// Add a random offset
			dx += point_x;
			dy += point_y;

			// Delete and recreate the path using the new offset as target
			path_delete(path);
			path = path_add();
			mp_grid_path(global.grid, path, x, y, dx, dy, true);
		}
	}

	// Start moving along the (possibly offset) path
	path_start(path, move_speed, path_action_stop, true);
}


function get_list_of_nearest_allies()
{
	//collision with allies
	ds_list_clear(ally_list);
	current_list_size = 0;
	nearest_ally = noone;
	min_dist = 999999; // Start with a large number

	with (obj_enemy_collision_1) 
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
}

function move_away_from_ally()
{
	if (nearest_ally != noone) 
	{
	    distance = point_distance(x, y, nearest_ally.x, nearest_ally.y);
	    dir_away = point_direction(x, y, nearest_ally.x, nearest_ally.y) + 180;

	    line_length = clamp(min_distance_to_ally - distance, 0, min_distance_to_ally);

	    point_x = x + lengthdir_x(line_length, dir_away);
	    point_y = y + lengthdir_y(line_length, dir_away);
	}	
}