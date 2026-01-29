if (image_index >= image_number - 1) image_index = image_number - 1;
draw_sprite_ext(
current_bullet_type.sprite , 
image_index, 
x, 
y, 
1, 
1, 
image_angle+rotation,
c_white, 
1
);
