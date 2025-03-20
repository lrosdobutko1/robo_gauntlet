torso = spr_enemy1_torso;

var angle_diff = angle_difference(rotation_angle, point_direction(x,y,obj_player_legs.x,obj_player_legs.y)-90);
if (spotted_player) rotation_angle -= min(abs(angle_diff), 1.5) * sign(angle_diff);

sight_cone = get_sight_cone(x,y,60,sight_line_length,rotation_angle+90);

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

/*draw other elements*/

draw_path(path,x,y,true);

get_sight_line(x,y, rotation_angle+90, vis_dist, obj_obstacle);
draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);
