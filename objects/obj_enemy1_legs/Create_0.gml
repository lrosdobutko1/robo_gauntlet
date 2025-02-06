image_scale = 2;

image_speed = 0;
image_xscale = image_scale;
image_yscale = image_scale;

walk_left = false;
walk_right = false;
walk_up = false;
walk_down = false;

tile_map = layer_tilemap_get_id("level_tiles");

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

walk_speed = 1.1;

