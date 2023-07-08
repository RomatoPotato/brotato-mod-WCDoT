extends Node

const MENUSTRING_LOG = "RomatoPotato-WCDoT"

func _init(modLoader = ModLoader):
	ModLoaderLog.info("Init", MENUSTRING_LOG)
	ModLoaderMod.install_script_extension("res://mods-unpacked/RomatoPotato-WCDoT/extensions/entities/units/player/player.gd")

func _ready():
	ModLoaderLog.info("Ready", MENUSTRING_LOG)
