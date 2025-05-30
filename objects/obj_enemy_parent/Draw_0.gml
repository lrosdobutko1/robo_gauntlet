


if (health_state != HEALTH_STATE.DEAD && health_state != HEALTH_STATE.DESTROYED)
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

else
{

	draw_sprite_ext(spr_explode1,explode_anim,x,y,2,2,random_range(0,359),c_white,1)
	explode_anim += 0.75;

}


//if (path_exists(path))
//draw_path(path,x,y,true);
	
/*draw other elements*/
//get_sight_line(x,y, rotation_angle, vis_dist, obj_obstacle);
//draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);
//draw_line(x,y, move_away.px,move_away.py);

//draw_triangle(x,y,gun_barrels[0], gun_barrels[1], gun_barrels[2], gun_barrels[3], 5) ;