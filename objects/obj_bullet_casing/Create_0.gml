speed = random_range(4, 12);
image_speed = 0;
direction = image_angle;
smoke = false;
image_scale = 0;
life_time = 0;
if (obj_player_functions.current_weapon == current_weapon.flamer) smoke = true;

if (smoke)
{
image_index = 1;
image_scale = 4;
life_time = 20;
}
else
{
image_index = 0;
image_scale = 1;
life_time = 600;
}
rotation_frames = random_range(20,60); 
rotation_speed = random_range(-10,10); 

image_scalar =1;
scale_direction = 1;