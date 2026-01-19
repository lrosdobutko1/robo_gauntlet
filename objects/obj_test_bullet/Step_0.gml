var dx = lengthdir_x(bullet_speed, image_angle);
var dy = lengthdir_y(bullet_speed, image_angle);
move_and_collide(dx, dy, obj_wall_parent, 2);

