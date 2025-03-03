
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

/// Step Event of Moving Object
var grid = global.grid; // Assuming you have a shared grid
var self_x = x div 26;
var self_y = y div 26;

if (pathfinding_timer <= 0)
{
	
	path_delete(path);
	path = path_add();

	target_x = obj_player_torso.x;
	target_y = obj_player_torso.y;

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
	
    // Face toward the next node instead of the player
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
