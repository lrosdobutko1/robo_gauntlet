

var hit = resolve_x_collision(hspeed, obj_obstacle);

if (hit != noone) show_debug_message("i hit something");
else show_debug_message("I hit nothing");


//if (place_meeting(x+h_speed,y,obj_wall_parent))
//{
//	while (!place_meeting(x+(sign(h_speed)), y, obj_wall_parent))
//	{
//		x += sign(h_speed);
//	}
//	h_speed = 0;
//}

//if (place_meeting(x,y+v_speed,obj_wall_parent))
//{
//	while (!place_meeting(x, y+(sign(v_speed)), obj_wall_parent))
//	{
//		y += sign(v_speed);
//	}
//	v_speed = 0;
//}

//x+= h_speed;