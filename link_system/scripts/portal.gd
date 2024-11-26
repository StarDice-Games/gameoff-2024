extends Area2D
class_name Portal

@export var level_id : String
@export var link_id : String


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	LevelSystem.load_level("esterno")
