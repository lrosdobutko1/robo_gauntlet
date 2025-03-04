
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

var nearest_ally = noone;
var min_dist = 999999; // Start with a large number

with (obj_enemy_parent) {
    if (id != other.id) { // Exclude itself
        var dist = point_distance(other.x, other.y, x, y);
        if (dist < min_dist) {
            min_dist = dist;
            nearest_ally = id;
        }
    }
}
var distance = point_distance(x,y,nearest_ally.x,nearest_ally.y);

if (distance < 48)
{
	show_debug_message("I am too close");	
}

if (pathfinding_timer <= 0)
{
	if (distance_to_object(obj_player_legs) >= 52)
	{
		var change_target_x = obj_player_legs.x + irandom_range(-50, 50);
		var change_target_y = obj_player_legs.y + irandom_range(-50, 50);
		
		while (!mp_grid_path(global.grid, path, x, y, change_target_x, change_target_y, true))
		{
			change_target_x = obj_player_torso.x + irandom_range(-50, 50);
			change_target_y = obj_player_torso.y + irandom_range(-50,50);
		}
		
		target_x = change_target_x;
		target_y = change_target_y;
	}
	else
	{
		target_x = obj_player_torso.x;
		target_y = obj_player_torso.y;
	}
	
	mp_grid_path(global.grid, path, x, y, target_x, target_y, true)
	path_delete(path);
	path = path_add();

	mp_grid_path(global.grid, path, x, y, target_x, target_y, true);

	path_start(path, walk_speed*global.delta_multiplier, path_action_stop, true);
	
	pathfinding_timer = irandom_range(pathfinding_cooldown/2, pathfinding_cooldown);
}

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

if (hp <= 0) alive = false;
if (!alive)
{
	instance_create_layer(x,y,"explosions",obj_explosions);
	instance_create_layer(x,y,"scorch_marks",obj_scorch_mark);
	instance_destroy();
}




// `nearest` now holds the closest instance's ID, or `noone` if none exist.