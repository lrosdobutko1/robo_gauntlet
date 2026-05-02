cam = view_camera[0];
follow = obj_player_collision;

cam_width = 1280;
cam_height = 540;

cam_w_half = camera_get_view_width(cam) / 2;
cam_h_half = camera_get_view_height(cam) / 2;

x_to = xstart;
y_to = ystart;


if (layer_exists("Background"))
{
	background = layer_get_id("Background");
}

global.explosion_list = ds_list_create();