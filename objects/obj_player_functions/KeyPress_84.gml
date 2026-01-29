//instance_create_layer(mouse_x,mouse_y,"enemy_layer",obj_enemy_1);

var _b = (instance_create_layer(x,y,"player_legs",obj_bullets)) {
	
	_b.creator = obj_player_functions; // Store gun reference
	_b.current_bullet_type = bullet_types.flamer;	
	_b.speed = 0;
	_b.direction =0;
	_b.image_angle =0;
	_b.x = mouse_x;
	_b.y = mouse_y;
	_b.sprite_index = _b.current_bullet_type.sprite;
	_b.life_timer = _b.current_bullet_type.life_timer;
}