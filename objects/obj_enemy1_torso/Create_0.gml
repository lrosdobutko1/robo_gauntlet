
x = obj_enemy1_legs.x;
y = obj_enemy1_legs.y;

max_level = 100;
level = 1;
hp = 100 * level;

shields = 100;

image_scale = obj_enemy1_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;

color_scale = 120 + (240 * (level / max_level));
level_color = (255 / 360) * color_scale;
image_blend = make_color_hsv(level_color, 255, 255);
