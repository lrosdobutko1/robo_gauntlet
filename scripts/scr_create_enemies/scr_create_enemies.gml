/// @function create_enemy_types
/// @description creates the various enemy types to be deployed throughout the game area
/// @param {string}  _enemy_name,
/// @param {int}	 _enemy_level,
/// @param {real}    _base_hp,
/// @param {real}	 _base_damage,
/// @param {real}	 _base_shields,
/// @param {int}	 _move_speed,
/// @param {array}	 _enemy_sprites,
/// @param {boolean} _intelligent
/// @param {real}    _base_xp_on_death
/// @returns a struct of an enemy type
function create_enemy_types(
_enemy_name,
_enemy_level,
_base_hp,
_base_damage,
_base_shields,
_move_speed,
_enemy_sprites,
_intelligent,
_base_xp_on_death
) {
	return {
		enemy_name:	      _enemy_name,
		enemy_level:	  _enemy_level,
		base_hp:		  _base_hp,
		base_damage:	  _base_damage,
		base_shields:	  _base_shields,
		move_speed:		  _move_speed,
		enemy_sprites:    _enemy_sprites,
		is_intelligent:   _intelligent,
		base_xp_on_death: _base_xp_on_death
	}
}
