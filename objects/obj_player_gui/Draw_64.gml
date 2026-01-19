rotation += 0.25;
draw_sprite_ext(border,0,100,100,1,1,0,c_white,1);
draw_sprite_ext(orb,0,100,100,1,1,0,c_white,1);
draw_sprite_ext(spr_player_health_spinner,0,100,100,1,1,rotation,c_white,1);

current_hp = player.current_hp;
max_hp = player.max_hp;
hp_percent = (current_hp / max_hp);

//draw_set_font(fnt_hyper_oxide);


current_shield = player.current_shields;
max_shields = player.max_shields;
shield_percent = current_shield / max_shields;
if (shield_percent <= 0) shield_percent = 0;
if (shield_percent >= 1) shield_percent = 1;

current_bar_length = max_bar_length * shield_percent;
draw_sprite_ext(bar,0,186,95,current_bar_length,1,0,c_white,1);


if (took_damage) damage_counter_value --;
if (damage_counter_value <= 0) {
	took_damage = false;
	damage_counter_value = damage_counter;
}
if(!took_damage) player.current_shields += 0.01;
if (player.current_shields >= player.max_shields) player.current_shields = player.max_shields;

draw_text_colour(50,75,round(hp_percent*100),c_black,c_grey,c_blue,c_red,1);



