lifetime --;
for (var i = lifetime; i > 1; i--;)
	with (instance_create_layer(x, y, "player_bullets", obj_spark))
	{
		speed = 2;
		direction = other.direction - 90 + random_range(-35,155);
	}
	
if (lifetime < 0) instance_destroy();