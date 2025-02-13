x = obj_player_legs.x;
y = obj_player_legs.y;
image_angle = point_direction(x,y, mouse_x,mouse_y)-90;

center_x = x;   // Center X of the circle
center_y = y;   // Center Y of the circle
angle += search_speed; // Increase the angle over time
search_x = center_x + radius * cos(angle);
search_y = center_y + radius * sin(angle);

show_debug_message(string(search_x) + " " + string(search_y));