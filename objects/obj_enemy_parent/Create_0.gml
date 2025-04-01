
//sprite info
image_scale = 1.25;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

torso = spr_enemy1_torso;
rotation_angle = irandom_range(0,360);
current_angle = rotation_angle;
target_angle = angle_difference(rotation_angle,current_angle);
//if an enemy is "smart" it will do things like lead shots against the player, and other advanced behavior
is_smart = false;

//line of sight
vis_dist = 500;
sight_line_length = get_sight_line(x,y,rotation_angle, vis_dist, obj_obstacle);
sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);

spotted_player = false;
leading_player = false;
searching_player = false;
search_cooldown = 1200;
search_timer = 0;

last_known_player_x = 0;
last_known_player_y = 0;
predicted_x = 0;
predicted_y = 0;

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

//shooting
gun_barrels = array_create(4);
left_gun_barrel = array_create(2);
right_gun_barrel = array_create(2);
gun_cooldown = 100;
gun_timer = 0;
shooting_range = 500;
firing_offset = 10;
//determine how much lead time to give the enemy when tracking player. Between 0 and 1.
prediction_multiplier = (is_smart) ? 1 : 0;

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

function move_to_location(go_to_x, go_to_y)
{
	path_delete(path);
	path = path_add();

	mp_grid_path(global.grid, path, x, y, go_to_x, go_to_y, true);
	path_start(path, walk_speed * global.delta_multiplier, path_action_stop, true);
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
	var player_lead_direction = point_direction(x,y, predicted_x, predicted_y)-90;
	var player_target_transition = point_direction(obj_player_collision.x,obj_player_collision.y,predicted_x,predicted_y)-90;

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

	// Direction to the mouse
	facing_angle = rotation_angle+90;

	// Calculate the positions of the two equal points
	var angle1 = facing_angle - spread_angle / 2; // First point's angle
	var angle2 = facing_angle + spread_angle / 2; // Second point's angle

	coords[0] = x_fixed + lengthdir_x(radius, angle1);
	coords[1] = y_fixed + lengthdir_y(radius, angle1);
	coords[2] = x_fixed + lengthdir_x(radius, angle2);
	coords[3] = y_fixed + lengthdir_y(radius, angle2);
}

tick_tock_counter = 0;  
tick_tock_offset = 20; // Default offset, always a multiple of 10

function tick_tock(offset)
{
	find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);
	var creator = id;
	
    static tick_tock_counter = 0;
    static cycle_count = 0;

    if (tick_tock_counter == 0)
    {
		var right_bullets = instance_create_layer(
		gun_barrels[0],
		gun_barrels[1],
		layer,
		obj_bullets)
		{
			right_bullets.image_angle = rotation_angle;	
			right_bullets.direction = right_bullets.image_angle+90;
			right_bullets.x = gun_barrels[0];
			right_bullets.y = gun_barrels[1];
			right_bullets.gun_parent = creator; // Store gun reference
			right_bullets.is_left = false;
		}	

    fire_guns_counter = offset; // Start countdown
        show_debug_message("Tick");
        tick_tock_counter = offset; // Start countdown
    }
    else if (tick_tock_counter == offset - offset/2) // 20 steps after "Tick"
    {
		var left_bullets = instance_create_layer(
		gun_barrels[2],
		gun_barrels[3],
		layer,
		obj_bullets)
		{
		left_bullets.image_angle = rotation_angle;	
		left_bullets.direction = left_bullets.image_angle+90;
		left_bullets.x = gun_barrels[2];
		left_bullets.y = gun_barrels[3];
		left_bullets.gun_parent = creator; // Store gun reference
		left_bullets.is_left = true;
		}
        show_debug_message("Tock");
        cycle_count += 1; // Increment cycle count

        if (cycle_count >= 4) // If 4 cycles completed
        {
            tick_tock_counter = -120; // Pause for 120 frames
            cycle_count = 0; // Reset cycle count
        }
    }

    if (tick_tock_counter > 0) 
    {
        tick_tock_counter -= 1;
    }
    else if (tick_tock_counter < 0) 
    {
        tick_tock_counter += 1; // Countdown during pause period
    }
}



//function shoot_enemy_bullets()
//{
//	find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);
	
//	var creator = id;
	
//	//right gun
//	var right_bullets = instance_create_layer(
//	gun_barrels[0],
//	gun_barrels[1],
//	layer,
//	obj_bullets)
//	{
//		right_bullets.image_angle = rotation_angle;	
//		right_bullets.direction = right_bullets.image_angle+90;
//		right_bullets.gun_parent = creator; // Store gun reference
//		right_bullets.is_left = false;
//	}	


//	//left gun
//	var left_bullets = instance_create_layer(
//	gun_barrels[2],
//	gun_barrels[3],
//	layer,
//	obj_bullets)
//	{
//		left_bullets.image_angle = rotation_angle;	
//		left_bullets.direction = left_bullets.image_angle+90;
//		left_bullets.x = gun_barrels[2];
//		left_bullets.y = gun_barrels[3];
//		left_bullets.gun_parent = creator; // Store gun reference
//		left_bullets.is_left = true;
//	}
//}

