extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventSystem.stop_sound.emit("Police_Siren_01")
	EventSystem.play_music.emit("go2024_briefing")
	EventSystem.cutscene_started.emit()
	EventSystem.hide_hud.emit()
	$AnimationPlayer.play("credits")

func return_to_main_menu():
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	LevelSystem.load_level("esterno_title")
