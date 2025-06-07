if (alive) draw_self();

else
{
	draw_sprite_ext(spr_explode1,explode_anim,x,y,1,1,0,c_white,1)	
	explode_anim += 0.5;
	camera_shake();
	if (explode_anim >= (sprite_get_number(spr_explode1) - 1))
	{
		global.shaking = false;
		instance_destroy();	
	}
}