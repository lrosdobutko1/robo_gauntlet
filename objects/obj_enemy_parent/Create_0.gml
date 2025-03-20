
//sprite info
image_scale = 1.25;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

torso = spr_enemy1_torso;
rotation_angle = image_angle;

//line of sight
vis_dist = 500;
sight_line_length = get_sight_line(x,y,rotation_angle, vis_dist, obj_obstacle);
sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);

movement = movement_state.NONE;
attacking = attack_state.NONE;
searching = searching_state.NONE;

spotted_player = false;
searching_player = false;

last_known_player_x = 0;
last_known_player_y = 0;

//behavior
enum movement_state 
{
	NONE,
	GUARDING,
	SEARCHING,
	PATROLLING,
	CHASING,
	DODGING,
}

enum attack_state
{
	NONE,
	ATTACKING,
	TARGETING,
}

enum searching_state
{
	NONE,
	SCANNING,
	SPOTTED,
}

//movement info
previous_x = x;
previous_y = y;

moving = false;

walk_speed = 0.8;
current_list_size = 0;
nearest_ally = noone;
min_dist = 99999999; // Start with a large number

player_previous_x = obj_player_legs.x;
player_previous_y = obj_player_legs.y;

//pathfinding
initial_path = true;
pathfinding_cooldown = 120;
pathfinding_timer = 0;
path = path_add();

target_x = obj_player_legs.x;
target_y = obj_player_legs.y;

ally_list = ds_list_create();
previous_list_size = 0;

// drawa a line away from nearby allies
distance = 0;
dir_away = 0;
line_length = 0;

point_x = 0;
point_y = 0;

min_distance_to_ally = 50;

//determine if legs remain after destruction
random_legs = random_range(0,10);

//level and health information
max_level = 5;
level = 1;
starting_hp = 40;
starting_damage = 2;
hp = (starting_hp * level) + power(level,level);
damage = starting_damage * power(level,2);
shields = hp/2;
alive = true;

colors = [c_white, c_green, c_blue, c_yellow, c_red, c_purple];
sprite_color = colors[level];
flash = 0;

/// Draw an infinitely long line that stops on collision
function get_sight_line(x_start, y_start, angle, vis_dist, target_object) {
    var max_distance = vis_dist; // Large value to simulate infinity
    var step_size = 1;        // How fine the collision check is
    
    var x_end = x_start;
    var y_end = y_start;
	var line_length = max_distance;
    
    for (var i = 0; i < max_distance; i += step_size) {
        x_end = x_start + lengthdir_x(i, angle);
        y_end = y_start + lengthdir_y(i, angle);
        
        // Pixel-perfect collision check
        if (position_meeting(x_end, y_end, target_object)) {
			line_length = i;
            break; // Stop when collision is detected
        }
    }
    draw_line(x_start,y_start,x_end,y_end);
	return line_length;
}


function get_sight_cone(xA, yA, spread_angle, height, direction) {
    var half_angle = spread_angle / 2;
    
    // Calculate half the base length using the tangent function
    var base_half = height * tan(degtorad(half_angle));
    
    // Find the midpoint of the base at the given height
    var x_mid = xA + lengthdir_x(height, direction);
    var y_mid = yA + lengthdir_y(height, direction);
    
    // Calculate the base endpoints (B and C)
    var xB = x_mid + lengthdir_x(base_half, direction - 90);
    var yB = y_mid + lengthdir_y(base_half, direction - 90);
    
    var xC = x_mid + lengthdir_x(-base_half, direction - 90);
    var yC = y_mid + lengthdir_y(-base_half, direction - 90);
    
    return [xB, yB, xC, yC];
}

function scan_area()
{
	var scanning_time = irandom_range(120, 360);
	var scanning_direction_time = scanning_time div 2;
	
	//if (spotted_player);
	
	
}

function chase_player()
{
	var player_moved = (player_previous_x != obj_player_legs.x || player_previous_y != obj_player_legs.y);

	if (initial_path || player_moved)
	{
		//while far from the player
	    if (distance_to_object(obj_player_legs) >= 104)
	    {
	        var change_target_x = obj_player_legs.x + irandom_range(-50, 50);
	        var change_target_y = obj_player_legs.y + irandom_range(-50, 50);

	        while (!mp_grid_path(global.grid, path, x, y, change_target_x, change_target_y, true))
	        {
	            change_target_x = obj_player_legs.x + irandom_range(-50, 50);
	            change_target_y = obj_player_legs.y + irandom_range(-50, 50);
	        }

	        target_x = change_target_x;
	        target_y = change_target_y;
	    }
	    else
	    {
	        target_x = last_known_player_x;
	        target_y = last_known_player_y;
	    }

	    //delete and create a new path only when updating
	    path_delete(path);
	    path = path_add();

	    mp_grid_path(global.grid, path, x, y, target_x, target_y, true);
		path_start(path, walk_speed * global.delta_multiplier, path_action_stop, true);
	}
	
	//once the player is near
	if (distance_to_object(obj_player_legs) < 104)
	{
	    target_x = obj_player_legs.x;
	    target_y = obj_player_legs.y;
	}

	//delete and create a new path only when updating
	path_delete(path);
	path = path_add();

	mp_grid_path(global.grid, path, x, y, target_x, target_y, true);
		path_start(path, walk_speed * global.delta_multiplier, path_action_stop, true);
	
	//update previous position only after pathfinding check
	player_previous_x = obj_player_legs.x;
	player_previous_y = obj_player_legs.y;

	pathfinding_timer = irandom_range(pathfinding_cooldown / 2, pathfinding_cooldown);
	initial_path = false;
}