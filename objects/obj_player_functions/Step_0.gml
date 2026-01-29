


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
	//firing = true;
	    if (firing_speed_cooldown <= 0)
    {
        find_gun_create_coordinates(gun_barrels, 26, 60);
        shoot_bullets(
            id,
            gun_barrels[0],
            gun_barrels[1],
            current_weapon.firing_speed,
            current_weapon.firing_speed_offset,
            current_weapon,
            current_weapon.bullet_angle,
            current_weapon.num_bullets,
            damage
        );

        firing_speed_cooldown = current_weapon.firing_speed;
    }

    if (firing_speed_cooldown == current_weapon.firing_speed * current_weapon.firing_speed_offset)
    {
        find_gun_create_coordinates(gun_barrels, 26, 60);
        shoot_bullets(
            id,
            gun_barrels[2],
            gun_barrels[3],
            current_weapon.firing_speed,
            current_weapon.firing_speed_offset,
            current_weapon,
            current_weapon.bullet_angle,
            current_weapon.num_bullets,
            damage
        );
    }
}
else
{
	firing = false;
}

///fire secondary
if (mouse_check_button(2) && rockets_ready)
{

}



if (firing)
{
    //if (firing_speed_cooldown <= 0)
    //{
    //    find_gun_create_coordinates(gun_barrels, 26, 60);
    //    shoot_bullets(
    //        id,
    //        gun_barrels[0],
    //        gun_barrels[1],
    //        current_weapon.firing_speed,
    //        current_weapon.firing_speed_offset,
    //        current_weapon,
    //        current_weapon.bullet_angle,
    //        current_weapon.num_bullets,
    //        damage
    //    );

    //    firing_speed_cooldown = current_weapon.firing_speed;
    //}

    //if (firing_speed_cooldown == current_weapon.firing_speed * current_weapon.firing_speed_offset)
    //{
    //    find_gun_create_coordinates(gun_barrels, 26, 60);
    //    shoot_bullets(
    //        id,
    //        gun_barrels[2],
    //        gun_barrels[3],
    //        current_weapon.firing_speed,
    //        current_weapon.firing_speed_offset,
    //        current_weapon,
    //        current_weapon.bullet_angle,
    //        current_weapon.num_bullets,
    //        damage
    //    );
    //}
}

firing_speed_cooldown --;
