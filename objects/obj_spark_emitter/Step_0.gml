
lifetime --;

//for (var i = lifetime; i > 1; i--)
//	with (instance_create_layer(x, y, layer, obj_spark))
//	{
//		speed = random_range(.01,8)*lifetime;
//		direction = other.direction - 90 + random_range(-35,155);
//	}

if (lifetime < 0) instance_destroy();
