

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

//check the nearest ally, and plot a vector away from that ally
if (nearest_ally != noone) 
{
    distance = point_distance(x, y, nearest_ally.x, nearest_ally.y);
    dir_away = point_direction(x, y, nearest_ally.x, nearest_ally.y) + 180;

    line_length = clamp(min_distance_to_ally - distance, 0, min_distance_to_ally);

    point_x = x + lengthdir_x(line_length, dir_away);
    point_y = y + lengthdir_y(line_length, dir_away);
}



//pathfinding
pathfinding --;
player_current_x = obj_player_collision.x;
player_current_y = obj_player_collision.y;

//if(created) chase_player(player_current_x, player_current_y, player_moved, created, point_x, point_y);

if (pathfinding <= 0)
{
	basic_chase_player(point_x-x, point_y-y);
	//chase_player(player_current_x, player_current_y, player_moved, created, point_x, point_y);
	pathfinding = irandom_range(pathfinding_cooldown / 2, pathfinding_cooldown);
}

player_moved = ((player_current_x != previous_player_x) || (player_current_y != previous_player_y));

previous_player_x = obj_player_collision.x;
previous_player_y = obj_player_collision.y;



if (id == 100005)
show_debug_message("point X: " + string(point_x-x) + " point Y: " + string(point_y-y));

created = false;