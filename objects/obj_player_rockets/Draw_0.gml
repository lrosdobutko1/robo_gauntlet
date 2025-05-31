if (alive) draw_self();

else
{
	explode_anim += 0.5;
	if (explode_anim >= (sprite_get_number(spr_explode1) - 1))
	instance_destroy();	
	camera_shake();
	draw_sprite_ext(spr_explode1,explode_anim,x,y,1,1,0,c_white,1)	
}