extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventSystem.stop_sound.emit("Police_Siren_01")
	EventSystem.play_music.emit("go2024_briefing")
	EventSystem.cutscene_started.emit()
	EventSystem.hide_hud.emit()
	
	$AnimationPlayer.play("credits")
	
	if TriggersSystem.check_trigger("show_credits", true):
		$AnimationPlayer.seek(11.5, true)

func return_to_main_menu():
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if TriggersSystem.check_trigger("show_credits", true):
			TriggersSystem.toggle_trigger("show_credits")
		LevelSystem.load_level("esterno_title")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if TriggersSystem.check_trigger("show_credits", true):
		TriggersSystem.toggle_trigger("show_credits")
	LevelSystem.load_level("esterno_title")
