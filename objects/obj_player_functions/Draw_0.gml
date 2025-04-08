rotation_angle = point_direction(x,y, mouse_x,mouse_y)-90;
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

//if(firing)
//{
//	get_sight_line(gun_barrels[0],gun_barrels[1],rotation_angle+90,obj_obstacle);
//	get_sight_line(gun_barrels[2],gun_barrels[3],rotation_angle+90,obj_obstacle);
//}