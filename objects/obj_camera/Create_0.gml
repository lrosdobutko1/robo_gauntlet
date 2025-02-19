camWidth = 1024;
camHeight = 768;

follow = obj_player_collision;
//follow = obj_player_torso;

xTo = x;
yTo = y;

if (layer_exists("Background"))
{
	background = layer_get_id("Background");
}