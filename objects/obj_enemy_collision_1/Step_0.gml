
get_list_of_nearest_allies();

move_away_from_ally();

//pathfinding
pathfinding --;
player_current_x = obj_player_collision.x;
player_current_y = obj_player_collision.y;


if (pathfinding <= 0)
{
	basic_chase_player(point_x-x, point_y-y, walk_speed);
	
	pathfinding = irandom_range(pathfinding_cooldown / 2, pathfinding_cooldown);
}

player_moved = ((player_current_x != previous_player_x) || (player_current_y != previous_player_y));

previous_player_x = obj_player_collision.x;
previous_player_y = obj_player_collision.y;

if (created)
created = false;