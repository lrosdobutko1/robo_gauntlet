

if (alive)
{

	//draw the torso
	draw_self();
	draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
	
	if (flash > 0)
	{
		flash --;
		shader_set(sh_white);
		draw_self();
		draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
		shader_reset();
	}
	
	//draw_path(path,x,y,true);
	
	/*draw other elements*/
	get_sight_line(x,y, rotation_angle+90, vis_dist, obj_obstacle);
	draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);
}


draw_set_color(c_red);
draw_circle(predicted_x, predicted_y, 10, false);

draw_triangle(x,y,gun_barrels[0],gun_barrels[1],gun_barrels[2],gun_barrels[3], 3);

