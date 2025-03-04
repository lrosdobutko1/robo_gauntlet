
moving = false;

h_speed = obj_player_collision.h_speed * global.delta_multiplier;
v_speed = obj_player_collision.v_speed * global.delta_multiplier;

var next_x = x + obj_player_collision.h_speed;
var next_y = y + obj_player_collision.v_speed;

var angle_diff = angle_difference(image_angle, point_direction(x,y,next_x,next_y)-90);

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
	image_speed = 1;
	image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);

}
else
{
	image_speed = 0;
}

////collision detection
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

//x += h_speed;
//y += v_speed;

////move_and_collide(h_speed, v_speed, [obj_wall, obj_obstacle])

x = obj_player_collision.x;
y = obj_player_collision.y;

var nearest_enemy = instance_nearest(x,y,obj_enemy_1);