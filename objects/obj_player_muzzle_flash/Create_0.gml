image_angle = 0;
image_speed = 0;
if(obj_player_functions.player_gun_type != PLAYER_GUN_TYPE.BLASTER)
random_image_index = irandom_range(0,7);
else
random_image_index = irandom_range(8,15);
image_index = random_image_index;
