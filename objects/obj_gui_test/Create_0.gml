self_text = "Nothing";
has_rendered = false;
x = obj_player_collision.x;
y = obj_player_collision.y;

uUv = shader_get_uniform(sdr_gradient, "uUv");
uOffset = shader_get_uniform(sdr_gradient, "uUv");

offset = 0.0;