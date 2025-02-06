
target_delta = 1/game_get_speed(gamespeed_fps);

actual_delta = delta_time/1000000;
global.delta_multiplier = actual_delta/target_delta;

delta = 0;
timer = 0;

player_gun_cooldown = 30;
player_gun_timer = player_gun_cooldown;