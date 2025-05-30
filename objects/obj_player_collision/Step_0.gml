
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
moving = false;

if (key_right)
{
	facing = directions.right;
}
else if (key_up)
{
	facing = directions.up;
}
else if (key_left)
{
	facing = directions.left;
}
else if (key_down)
{
	facing = directions.down;
}

// Calculate horizontal and vertical movement
var h_move = key_right - key_left;
var v_move = key_down - key_up;

// Calculate the length of the movement vector
var diag_mov = sqrt(h_move * h_move + v_move * v_move);

// Normalize the movement vector if it isn't zero
if (diag_mov > 0) {
    h_move /= diag_mov;
    v_move /= diag_mov;
}

h_speed = h_move * walk_speed * global.delta_multiplier;
v_speed = v_move * walk_speed * global.delta_multiplier;

var next_x = x + h_speed;
var next_y = y + v_speed;

var angle_diff = angle_difference(image_angle, point_direction(x,y,next_x,next_y)-90);

////animate legs
//if (h_speed != 0 || v_speed != 0)
//{
//	moving = true;
//}
//else 
//{
//	moving = false;
//}


//collision detection
if (place_meeting(x+h_speed,y,obj_wall_parent))
{
	while (!place_meeting(x+(sign(h_speed)), y, obj_wall_parent))
	{
		x += sign(h_speed);
	}
	h_speed = 0;
}

if (place_meeting(x,y+v_speed,obj_wall_parent))
{
	while (!place_meeting(x, y+(sign(v_speed)), obj_wall_parent))
	{
		y += sign(v_speed);
	}
	v_speed = 0;
}

x += h_speed;
y += v_speed;

//show_debug_message(hp);