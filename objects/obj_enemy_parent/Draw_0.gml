draw_self();

if (alive)
{
	draw_self();
	//draw the torso
	draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
	
	if (flash > 0)
	{
		flash --;
		shader_set(sh_white_flash);
		draw_self();
		draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
		shader_reset();
	}
}

//draw_path(path,x,y,true);
	
//	/*draw other elements*/
//	//get_sight_line(x,y, rotation_angle, vis_dist, obj_obstacle);
//	//draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);