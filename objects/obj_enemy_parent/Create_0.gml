created = true;
level = 2;



////sprite info
image_scale = 1.25;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;
colors = [c_white, c_green, c_blue, c_yellow, c_red, c_purple];
sprite_color = colors[level];
explode_anim = 0;

torso = spr_enemy1_torso;
rotation_angle = irandom_range(0,360);
current_angle = rotation_angle;
target_angle = angle_difference(rotation_angle,current_angle);

alive = true;
flash = 0;

////if an enemy is "smart" it will do things like lead shots against the player, and other advanced behavior
is_smart = false;

////line of sight
vis_dist = 500;
sight_line_length = get_sight_line(x,y,rotation_angle, vis_dist, obj_obstacle);
sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);

spotted_player = false;
leading_player = false;
searching_player = false;
search_cooldown = 1200;
search_timer = 0;

predicted_x = 0;
predicted_y = 0;

player_previous_x = obj_player_functions.x;
player_previous_y = obj_player_functions.y;

////movement info
previous_x = x;
previous_y = y;

moving = false;

 // Start with a large number



////pathfinding
//initial_path = true;
pathfinding_cooldown = 60;
pathfinding_timer = 0;


//shooting
enum SHOOTING_STATE
{
	SHOOTING_IDLE,
	PREPARING_TO_SHOOT,
	SHOOTING,
	SHOOTING_COOLDOWN,
}

enum HEALTH_STATE
{
	HIGH,
	MED,
	LOW,
	CRITICAL,
	DEAD,
	DESTROYED,
}

base_hp = 40;
starting_hp = (base_hp * level) + power(level,level);
hp = starting_hp;

if (hp == starting_hp) health_state = HEALTH_STATE.HIGH;

shooting_state = SHOOTING_STATE.SHOOTING_IDLE;

gun_barrels = array_create(4);
find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);

casings_eject = array_create(4);
find_enemy_gun_create_coordinates(casings_eject, 15, 170, rotation_angle);

gun_cooldown = 140;
preparing_to_shoot_timer = gun_cooldown;
shooting_range = vis_dist;
gun_offset_counter = 0;
fire_gun_offset = 40; 
shooting_time_reset = fire_gun_offset * 4;
shooting_time = shooting_time_reset;
shooting_cooldown_timer = 120;



////determine how much lead time to give the enemy when tracking player. Between 0 and 1.
prediction_multiplier = (is_smart) ? 1 : 0;



////level and health information
//max_level = 5;



base_damage = 2;
starting_damage = base_damage * power(level,2);
damage = starting_damage * power(level,2);
//shields = hp/2;


/// Draw an infinitely long line that stops on collision
function get_sight_line(x_start, y_start, angle, vis_dist, target_object) {
    var max_distance = vis_dist; // Large value to simulate infinity
    var step_size = 10;        // How fine the collision check is
    
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


function choose_torso_angle(prediction_multiplier)
{
	var distance_to_player = point_distance(x, y, obj_player_collision.x, obj_player_collision.y);
	var min_range = 0;
	var max_range = 500;

	var rotation_speed = clamp(3 - (distance_to_player - min_range) / (max_range - min_range) * 4, 1, 5);
	var min_time = 2;  // Minimum prediction frames
	var max_time = 80; // Maximum prediction frames
	var max_distance = 400; // Distance at which max_time applies
	var prediction_time = prediction_multiplier * (min_time + (max_time - min_time) * (distance_to_player / (distance_to_player + max_distance)));
	var player_moving = (player_previous_x != obj_player_collision.x || player_previous_y != obj_player_collision.y)

	var player_direction = point_direction(x,y,obj_player_collision.x,obj_player_collision.y)-90;
	var player_lead_direction = point_direction(x,y, predicted_x, predicted_y);
	var player_target_transition = point_direction(obj_player_collision.x,obj_player_collision.y,predicted_x,predicted_y);

	var target_player_stationary = angle_difference(rotation_angle, player_direction);
	var target_player_moving = angle_difference(rotation_angle, player_lead_direction);
	var target_player_moving_stationary = angle_difference(rotation_angle,player_target_transition);

	predicted_x = obj_player_collision.x + obj_player_collision.h_speed * prediction_time;
	predicted_y = obj_player_collision.y + obj_player_collision.v_speed * prediction_time;

	return min(abs(target_player_moving), rotation_speed) * sign(target_player_moving);	
}


function find_enemy_gun_create_coordinates(coords, radius, spread_angle, rotation_angle)
{
	
	//find the coordinates to create bullets at by calculating isoscoles triangle
	var x_fixed = x;
	var y_fixed = y;

	// Triangle parameters
	radius = radius * image_scale; // Distance from the fixed point to the other two points
	spread_angle = spread_angle; // Spread angle between the two equal points (in degrees)

	var facing_angle = rotation_angle;

	// Calculate the positions of the two equal points
	var angle1 = facing_angle - spread_angle / 2; // First point's angle
	var angle2 = facing_angle + spread_angle / 2; // Second point's angle

	coords[0] = x_fixed + lengthdir_x(radius, angle1);
	coords[1] = y_fixed + lengthdir_y(radius, angle1);
	coords[2] = x_fixed + lengthdir_x(radius, angle2);
	coords[3] = y_fixed + lengthdir_y(radius, angle2);
}


path = path_add();

pathfinding_cooldown = 20;
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

min_distance_to_ally = 50;



function get_list_of_nearest_allies()
{
	//collision with allies
	ds_list_clear(ally_list);
	current_list_size = 0;
	nearest_ally = noone;
	min_dist = 999; // Start with a large number

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
}


function move_away_from_ally(min_distance_to_ally)
{
	var distance;
	var dir_away;
	var line_length;
	var point_x;
	var point_y;
	if (nearest_ally != noone) 
	{
	   distance = point_distance(x, y, nearest_ally.x, nearest_ally.y);
	   dir_away = point_direction(x, y, nearest_ally.x, nearest_ally.y) + 180;

	    line_length = clamp(min_distance_to_ally - distance, 0, min_distance_to_ally);

	    point_x = x + lengthdir_x(line_length, dir_away);
	    point_y = y + lengthdir_y(line_length, dir_away);
	}	
	else
	{
		point_x = x;
		point_y = y;
	}
	
	return 
	({
		px: point_x,
		py: point_y
	});
}


function chase_player(player_current_x, player_current_y, player_moved, created, move_x, move_y) {
    var target_x = player_current_x;
    var target_y = player_current_y;
    var distance_to_player = point_distance(x, y, player_current_x, player_current_y);

    // Determine if a new path should be calculated
    var should_update_path = false;

    if (distance_to_player > 104)
	{
        if (created || player_moved || !path_exists(path)) 
		{
            should_update_path = true;
            // Add randomness to the target position
            target_x += irandom_range(-50, 50);
            target_y += irandom_range(-50, 50);
        }
    } 
	else 
	{
        // Always update path when close to the player
        should_update_path = true;
    }

    // Adjust target to avoid other enemies
    target_x += move_x;
    target_y += move_y;

    if (should_update_path) {
        // Delete existing path if it exists
        if (path_exists(path)) {
            //path_delete(path);
        }
        path = path_add();

        if (mp_grid_path(global.grid, path, x, y, target_x, target_y, true)) {
            path_start(path, walk_speed, path_action_stop, true);
        }
    }
}

firing_speed_cooldown = 40;
firing_speed = firing_speed_cooldown;
firing_offset = firing_speed*0.5;

function shoot_enemy_bullets(
gun_barrel_coords, 
firing_speed, 
firing_offset, 
damage
)
{
	find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);
	//find_enemy_gun_create_coordinates(casings_eject, 15, 170);

	var creator = id;
	

	if(firing_speed == firing_speed_cooldown)
	{
		//eject_shells(casings_eject[0], casings_eject[1], rotation_angle-90);
		create_bullet(creator, gun_barrel_coords[0], gun_barrel_coords[1], 0, 0, damage);

	}

	else if(firing_speed == firing_offset)
	{
		create_bullet(creator, gun_barrel_coords[2], gun_barrel_coords[3], 0, 0, damage);
	}
}

//function basic_chase_player(point_x, point_y, move_speed)
//{
//	var target_x = obj_player_collision.x;
//	var target_y = obj_player_collision.y;
//	var dx = path_get_point_x(path, 1);
//	var dy = path_get_point_y(path, 1);

//	// Delete the current path and make a fresh one
//	path_delete(path);
//	path = path_add();

//	// Generate an initial path to the player
//	if (mp_grid_path(global.grid, path, x, y, target_x, target_y, true))
//	{
//		var point_count = path_get_number(path);

//		// If path has at least 2 points, we can modify the second point
//		if (point_count > 1)
//		{
//			dx = path_get_point_x(path, 1);
//			dy = path_get_point_y(path, 1);

//			// Add a random offset
//			dx += point_x;
//			dy += point_y;

//			// Delete and recreate the path using the new offset as target
//			path_delete(path);
//			path = path_add();
//			mp_grid_path(global.grid, path, x, y, dx, dy, true);
//		}
//	}

//	// Start moving along the (possibly offset) path
//	//path_start(path, move_speed, path_action_stop, true);
//}