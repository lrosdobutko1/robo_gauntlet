
creator = other.object_index;

lifetime = 5;

function sparks(number_of_sparks, lower_angle, upper_angle, spark_speed)
{
		for (var i = number_of_sparks; i > 0; i--)
	{
		with instance_create_layer(x,y,"enemy_layer",obj_spark)
		{
			speed = spark_speed;
			direction = random_range(lower_angle,upper_angle);
		}
	}
}