extends Node

const MOD_DIR = "RomatoPotato-WCDoT/"
var dir = ""

func _init(_modLoader = ModLoaderMod):
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	
	ModLoaderMod.install_script_extension(dir + "extensions/entities/units/player/player.gd")
	ModLoaderMod.install_script_extension(dir + "extensions/weapons/ranged/carbon_bow/carbon_bow.gd")
