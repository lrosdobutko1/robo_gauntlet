camWidth = 1280;
camHeight = 540;

global.shake_call_count = 0;

follow = obj_player_collision;
//follow = obj_player_torso;

xTo = x;
yTo = y;

if (layer_exists("Background"))
{
	background = layer_get_id("Background");
}