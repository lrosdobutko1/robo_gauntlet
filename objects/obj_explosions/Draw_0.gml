draw_self();

draw_sprite_ext(sprite,-1,x,y,image_scale,image_scale,rotation,c_white,alpha);
if (shake_timer > 0)
{
	var dist = max(distance_to_object(obj_player_legs), 1);
	obj_camera.x += (random_range(-5,5) * clamp(250/dist,0,1));
	obj_camera.y += (random_range(-5,5) * clamp(250/dist,0,1));
}
shake_timer --;
if (image_index >= sprite_get_number(sprite) -1) 
{
	instance_destroy();
}

