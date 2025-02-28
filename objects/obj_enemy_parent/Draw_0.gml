torso = spr_enemy1_torso;
rotation_angle = point_direction(x,y, obj_player_torso.x,obj_player_torso.y)-90;
sight_cone = get_sight_cone(rotation_angle+90);

//draw legs


//draw the torso
if (alive)
{
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
}




//draw other elements
//draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);
//draw_line(x,y,facing_x, facing_y);

