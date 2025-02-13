image_scale = obj_player_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;


center_x = x;   // Center X of the circle
center_y = y;   // Center Y of the circle
radius = 100;     // Distance from center
angle = 0;        // Start angle in radians
search_speed = 0.05;     // Angular speed (radians per step)
search_x = center_x + radius * cos(angle);
search_y = center_y + radius * sin(angle);
