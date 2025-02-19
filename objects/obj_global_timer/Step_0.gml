
target_delta = 1/120;

actual_delta = delta_time/1000000;

//multiplier by which to multiply all timed effects like movement and cooldowns
global.delta_multiplier = actual_delta/target_delta;

delta = (delta_time/1000);

timer += delta;	
