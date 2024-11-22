class_name GlobalLevelSystem
extends Node2D

@export var levels_resources : Array[LevelData]
#TODO Maybe set this manually when the game is ready ?
var levels : Dictionary
var current_level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for data in levels_resources:
		levels[data.name] = data.scene

func load_level(key: String, transition: bool = false) -> void:
	if levels.has(key) :
		var level = levels[key]
		if level == null:
			printerr("LevelSystem Error level null.")
		current_level = key
		get_tree().change_scene_to_packed(level)
		if transition :
			TransictionScene.fade_in()
	else:
		printerr("LevelSystem Error level not found.")
	pass

func reload_current_level():
	if current_level != null and not current_level.is_empty():
		load_level(current_level)
	else:
		get_tree().reload_current_scene()
	TransictionScene.fade_in()
