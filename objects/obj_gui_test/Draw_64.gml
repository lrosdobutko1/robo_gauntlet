

if(!has_rendered)
{
		
	var _temp_surface = surface_create(300,50);
	surface_set_target(_temp_surface);
	draw_clear_alpha(c_black, 1);
	
	var _temp_layer = layer_create(0, "text");
	draw_set_font(fnt_hyper_oxide_32);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_white);
	
	draw_text(150, 35, self_text);
	text_sprite = sprite_create_from_surface(_temp_surface,0,0,300,50,1,0,150,25);
	
	//clean up
	layer_destroy(_temp_layer);
	surface_reset_target();
	surface_free(_temp_surface);
	
	has_rendered = true;
	
	sprite_index = text_sprite;
}

shader_set(sdr_gradient);
var _uv = sprite_get_uvs(sprite_index, image_index);
shader_set_uniform_f(uUv,_uv[1],_uv[3]);
shader_set_uniform_f(uOffset, offset);


draw_self();
shader_reset();