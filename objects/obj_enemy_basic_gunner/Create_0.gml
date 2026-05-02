// Inherit the parent event
event_inherited();

//shooting
enum SHOOTING_STATE
{
	SHOOTING_IDLE,
	PREPARING_TO_SHOOT,
	SHOOTING,
	SHOOTING_COOLDOWN,
}

shooting_state = SHOOTING_STATE.SHOOTING_IDLE;

gun_barrels = array_create(4);
find_enemy_gun_create_coordinates(gun_barrels, 20, 65,rotation_angle);

gun_cooldown = 140;
preparing_to_shoot_timer = gun_cooldown;
shooting_range = vis_dist;
gun_offset_counter = 0;
fire_gun_offset = 40; 
shooting_time_reset = fire_gun_offset * 4;
shooting_time = shooting_time_reset;
shooting_cooldown_timer = 120;

firing_speed_cooldown = 40;
firing_speed = firing_speed_cooldown;
firing_offset = firing_speed*0.5;

base_damage = 5;
damage = base_damage + (2 * level);
contact_damage = (level * level) * damage;

enemy_bullets = {
    default_bullet_type: create_bullet_types(id, "Default", damage, 6, -1, spr_player_bullet_cannon),
	}

current_bullet_type = enemy_bullets.default_bullet_type;