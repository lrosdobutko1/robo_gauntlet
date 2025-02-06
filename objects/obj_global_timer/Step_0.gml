
target_delta = 1/game_get_speed(gamespeed_fps);

actual_delta = delta_time/1000000;
global.delta_multiplier = actual_delta/target_delta;

delta = (delta_time/1000)

timer += delta;	

player_gun_timer -= delta;
if (player_gun_timer < 0) player_gun_timer = 0;
