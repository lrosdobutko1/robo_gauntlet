
target_delta = 1/game_get_speed(gamespeed_fps);

actual_delta = delta_time/1000000;
global.delta_multiplier = actual_delta/target_delta;

elapsed_frames = 0;
elapsed_milliseconds = 0;
elapsed_seconds = 0;