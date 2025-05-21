
//animation machinegun barrels
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

if (player_gun_type != PLAYER_GUN_TYPE.BLASTER)
{
	if (muzzle_flash_frame >= 7) muzzle_flash_frame = 0;
}
else if (player_gun_type == PLAYER_GUN_TYPE.BLASTER)
{
	if (muzzle_flash_frame >= 10) muzzle_flash_frame = 8;
}

if (firing) muzzle_flash_2(gun_barrels, firing_speed, firing_offset, player_gun_type, muzzle_flash_frame);

muzzle_flash_frame ++;


