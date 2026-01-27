image_scale = 1.5;
hp = 10;
image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

tile_map = layer_tilemap_get_id("level_tiles");

key_left = false;
key_right = false;
key_up = false;
key_down = false;
moving = false;

directions = 
{
	"right" : 270,
	"up" : 0,
	"left" : 90,
	"down" : 180
	};
	
facing = directions.up;

h_speed = 0;
v_speed = 0;

walk_speed = 2;
speed_multiplier = 1;
health_multiplier = 1;

damage_player = function(damage)
{
	obj_player_functions.hp -= damage;
}


