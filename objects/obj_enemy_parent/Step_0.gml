
sight_line_length = get_sight_line(x,y, rotation_angle+90, vis_dist, obj_obstacle);
sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);
spotted_player = point_in_triangle(obj_player_collision.x,obj_player_collision.y,x,y,sight_cone[0],sight_cone[1],sight_cone[2],sight_cone[3]);

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

//movement animation
var next_x = path_get_x(path, 1); // Get the next node's X position
var next_y = path_get_y(path, 1); // Get the next node's Y position
var travel_angle = point_direction(x, y, next_x, next_y);
var angle_diff = angle_difference(image_angle+90, travel_angle);

if (moving == true)
{
	image_speed = 0.8;
	
    //face toward the next node instead of the player
	image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);
}
else
{
	image_speed = 0;
}

//movement behavior
if (pathfinding_timer <= 0)
{
	//chase_player();
	pathfinding_timer = pathfinding_cooldown;
}

//destroyed
if (hp <= 0) alive = false;
if (!alive)
{
	instance_create_layer(x,y,"explosions",obj_explosions);
	instance_create_layer(x,y,"scorch_marks",obj_scorch_mark);
	instance_destroy();
}

//lead the player for shooting at

var distance_to_player = point_distance(x, y, obj_player_collision.x, obj_player_collision.y);
var min_range = 0;
var max_range = 500;

var rotation_speed = clamp(3 - (distance_to_player - min_range) / (max_range - min_range) * 4, 1, 5);
var min_time = 2;  // Minimum prediction frames
var max_time = 80; // Maximum prediction frames
var max_distance = 400; // Distance at which max_time applies
var prediction_time = min_time + (max_time - min_time) * (distance_to_player / (distance_to_player + max_distance));
var player_moving = (player_previous_x != obj_player_collision.x || player_previous_y != obj_player_collision.y)

var player_direction = point_direction(x,y,obj_player_collision.x,obj_player_collision.y)-90;
var player_lead_direction = point_direction(x,y, predicted_x, predicted_y)-90;
var player_target_transition = point_direction(obj_player_collision.x,obj_player_collision.y,predicted_x,predicted_y)-90;

var target_player_stationary = angle_difference(rotation_angle, player_direction);
var target_player_moving = angle_difference(rotation_angle, player_lead_direction);
var target_player_moving_stationary = angle_difference(rotation_angle,player_target_transition);

predicted_x = obj_player_collision.x + obj_player_collision.h_speed * prediction_time;
predicted_y = obj_player_collision.y + obj_player_collision.v_speed * prediction_time;

rotation_angle -= min(abs(target_player_moving), rotation_speed) * sign(target_player_moving);

player_previous_x = obj_player_collision.x;
player_previous_y = obj_player_collision.y;
