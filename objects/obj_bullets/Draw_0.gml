draw_sprite_ext(
sprite_index,
image_index,
x,
y,
image_xscale,
image_yscale,
image_angle,
c_white,
1);

if (current_bullet_type.bullet_name == "Rocket") draw_circle(x,y, aoe_radius,1);