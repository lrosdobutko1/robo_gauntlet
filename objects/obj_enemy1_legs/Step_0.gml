if (!instance_exists(obj_enemy1_torso)) instance_destroy();

moving = false;

if (walk_right)
{
	facing = directions.right;
}
else if (walk_up)
{
	facing = directions.up;
}
else if (walk_left)
{
	facing = directions.left;
}
else if (walk_down)
{
	facing = directions.down;
}

//
var angle_diff = angle_difference(image_angle, facing);

// Calculate horizontal and vertical movement
var h_move = walk_right - walk_left;
var v_move = walk_down - walk_up;

// Calculate the length of the movement vector
var diag_mov = sqrt(h_move * h_move + v_move * v_move);

// Normalize the movement vector if it isn't zero
if (diag_mov > 0) {
    h_move /= diag_mov;
    v_move /= diag_mov;
}

h_speed = h_move * walk_speed;
v_speed = v_move * walk_speed;

//animate legs
if (h_speed != 0 || v_speed != 0)
{
	moving = true;
}
else 
{
	moving = false;
}

if (moving == true)
{
	image_speed = 0.8;
	image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);

}
else
{
	image_speed = 0;
}

move_and_collide(h_speed, v_speed, [obj_wall, obj_obstacle])

