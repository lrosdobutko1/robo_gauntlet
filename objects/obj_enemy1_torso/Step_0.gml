if (hp <= 0)
{
	instance_destroy();	
}

image_angle = point_direction(x,y, obj_player_legs.x,obj_player_legs.y)-90;

x = obj_enemy1_legs.x;
y = obj_enemy1_legs.y;
