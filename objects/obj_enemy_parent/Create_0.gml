
//sprite info
image_scale = 1.25;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

torso = spr_enemy1_torso;
rotation_angle = point_direction(x,y, obj_player_torso.x,obj_player_torso.y);
sight_cone = get_sight_cone(rotation_angle);

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
pathfinding_cooldown = 600;
pathfinding_timer = 0;
path = path_add();

target_x = obj_player_torso.x;
target_y = obj_player_torso.y;

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

//line of sight
function get_sight_cone(rotation_angle)
{
	coords = [];

	radius = 300 * image_scale; // Distance from the fixed point to the other two points
	spread_angle = 60; // Spread angle between the two equal points (in degrees)

	facing_x = x + lengthdir_x(500, image_angle+90);
	facing_y = y + lengthdir_y(500, image_angle+90);
	vision_direction = rotation_angle;//point_direction(x, y, facing_x, facing_y);

	// Calculate the positions of the two equal points
	angle1 = vision_direction - spread_angle / 2; // First point's angle
	angle2 = vision_direction + spread_angle / 2; // Second point's angle

	coords[0] = x + lengthdir_x(radius, angle1);
	coords[1] = y + lengthdir_y(radius, angle1);
	coords[2] = x + lengthdir_x(radius, angle2);
	coords[3] = y + lengthdir_y(radius, angle2);
	
	return coords;	
}

function scanning()
{
	
}

