extends "res://entities/units/player/player.gd"

var spritesPath = "res://mods-unpacked/RomatoPotato-WCDoT/sprites/"

func add_weapon(weapon:WeaponData, pos:int)->void :
	# the lines below are Brotato's code
	# ---------------------------------------
	var instance = weapon.scene.instance()
	
	instance.weapon_pos = pos
	instance.stats = weapon.stats.duplicate()
	instance.weapon_id = weapon.weapon_id
	instance.tier = weapon.tier
	instance.weapon_sets = weapon.sets
	instance.connect("tracked_value_updated", weapon, "on_tracked_value_updated")
	
	for effect in weapon.effects:
		instance.effects.push_back(effect.duplicate())
	
	_weapons_container.add_child(instance)
	
	instance.global_position = position
	current_weapons.push_back(instance)
	_weapons_container.update_weapons_positions(current_weapons)
	
	# ----------------------------------------
	# My code (RomatoPotato's)
	# it sets texture depends on tier
	
	var newTexture = load(spritesPath + "/" + weapon.weapon_id + "/" + str(weapon.tier + 1) + ".png")
	
	if newTexture != null:
		instance.sprite.texture = newTexture
