rotation_angle = point_direction(x,y, mouse_x,mouse_y);
if (firing)
{
	gun_counter ++;
	if (gun_counter % 3 == 0)
	gun_index ++;
	if (gun_index == 3) gun_index = 0;
}
draw_self();
draw_sprite_ext(spr_player_guns,gun_index,obj_player_functions.x,obj_player_functions.y,image_scale,image_scale,rotation_angle,c_white,1);
draw_sprite_ext(spr_player_torso,0,obj_player_functions.x,obj_player_functions.y,image_scale,image_scale,rotation_angle,c_white,1);

draw_text(x+10, y+10, "FPS: " + string(fps_real));

draw_triangle(x,y,gun_barrels[0], gun_barrels[1], gun_barrels[2], gun_barrels[3],3);