var damage = max_damage;

with (other)
{
	if (shields > 0) shields -= damage;
	else if (shields <= 0) hp -= damage;
}
instance_create_layer(x, y, "player_bullets", obj_spark_emitter)
instance_destroy();