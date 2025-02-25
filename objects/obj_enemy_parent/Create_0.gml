
//sprite info
image_scale = 2;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

torso = spr_enemy1_torso;
rotation_angle = point_direction(x,y, obj_player_torso.x,obj_player_torso.y);
sight_cone = get_sight_cone(rotation_angle);

//movement info
previous_x = x;
previous_y = y;

tile_map = layer_tilemap_get_id("level_tiles");

moving = false;

walk_speed = 1.1;

pathfinding_cooldown = 120;
pathfinding_timer = 0;
path = path_add();

target_x = obj_player_torso.x;
target_y = obj_player_torso.y;

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

image_scale = obj_enemy_1.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;

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