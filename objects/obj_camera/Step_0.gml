//update destination

if (instance_exists(follow))
{
	x_to = follow.x;
	y_to = follow.y;
}

x += (x_to - x)/10;
y += (y_to - y)/10;

x = clamp(x, cam_w_half+500, room_width-cam_w_half);
y = clamp(y, cam_h_half+250, room_height-cam_h_half);


camera_set_view_pos(cam,x-(cam_w_half),y-(cam_h_half));



layer_x(background,x/2);
layer_y(background,y/2);


