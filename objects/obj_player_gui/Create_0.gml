player = obj_player_functions;

border = spr_player_health_border;
orb = spr_player_health_orb;
spinner = spr_player_health_spinner;
bar = spr_player_shield_bar;

current_hp = player.current_hp;
max_hp = player.max_hp;
hp_percent = current_hp / max_hp;

current_shield = player.current_shields;
max_shields = player.max_shields;
shield_percent = current_shield / max_shields;

max_bar_length = 265 * shield_percent;
current_bar_length = max_bar_length;

took_damage = false;

damage_counter = 240;
damage_counter_value = damage_counter;

rotation = 0;
