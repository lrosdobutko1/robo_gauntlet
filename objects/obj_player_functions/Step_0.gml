


if (current_hp == max_hp) health_state = PLAYER_HEALTH_STATE.FULL;
if (current_hp < max_hp && current_hp > max_hp * 0.75) health_state = PLAYER_HEALTH_STATE.HIGH;
if (current_hp <= max_hp * 0.75 && current_hp > max_hp * 0.25) health_state = PLAYER_HEALTH_STATE.MED;
if (current_hp <= max_hp * 0.25 && current_hp > max_hp * 0.10) health_state = PLAYER_HEALTH_STATE.LOW;
if (current_hp <= max_hp * 0.10 && current_hp > 0) health_state = PLAYER_HEALTH_STATE.CRITICAL;
if (current_hp <= 0) health_state = PLAYER_HEALTH_STATE.DEAD;
if (explode_anim >= (sprite_get_number(spr_explode1) - 1)) health_state = PLAYER_HEALTH_STATE.DESTROYED;


switch (health_state)
{
	case PLAYER_HEALTH_STATE.FULL:
	{
		
		break;
	}
	
	case PLAYER_HEALTH_STATE.HIGH:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.MED:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.LOW:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.CRITICAL:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.DEAD:
	{
		break;
	}
	
		case PLAYER_HEALTH_STATE.DESTROYED:
	{
		instance_destroy();
		break;
	}
	
}

//moving
x = obj_player_collision.x;
y = obj_player_collision.y;

//shooting
var prev_gun = gun_select_keys; // Store previous selection

// Check for key press
for (var i = 1; i <= array_length(weapon_slots)-1; i++)
{
    if (keyboard_check_pressed(ord(string(i))))
    {
        gun_select_keys = i;
        break;
    }
}

if (gun_select_keys != prev_gun)
{
    current_weapon = weapon_slots[gun_select_keys];
}

//fire primary
if (mouse_check_button(1))
{
	firing = true;
}
else
{
	firing = false;
}

///fire secondary
if (mouse_check_button(2) && rockets_ready)
{
	firing_rockets = true;
	rockets_ready = false;
}

if(firing_rockets) 
{
	shoot_rockets(rocket_offset);
	rocket_offset --;
	player_rocket_timer -= obj_global_timer.delta;
	if rocket_offset <= 0 firing_rockets = false;
}
else
{
	rocket_offset = rocket_offset_cd;
	if (!rockets_ready) player_rocket_timer -= obj_global_timer.delta;
	if (player_rocket_timer <= 0)
	{
		rockets_ready = true;
		player_rocket_timer = player_rocket_cooldown;
	}
}

if (firing)
{
	shoot_player_bullets(gun_barrels, 
	current_weapon.firing_speed, 
	current_weapon.firing_offset, 
	current_weapon, 
	firing_angle_offset, 
	no_of_bullets, 
	damage);
	firing_speed --;
	

	if (current_weapon == player_weapons.autocannon)
	{
		gun_anim += 0.33;
		if (gun_anim >= 4) gun_anim = 0;
	}
	else if (current_weapon == player_weapons.blaster) 
	{
		gun_anim += 0.15;
		if (gun_anim >= (sprite_get_number(spr_player_guns) - 1)) gun_anim = 5;
	}
}

if(firing_speed != firing_speed_cooldown)
{
	firing_speed --;
	if (firing_speed <= 0) firing_speed = firing_speed_cooldown;
}


//show_debug_message("player level: " + +string(level) + " health: " + string(hp) + "/" + string(max_hp) + " damage: " + string(damage));
