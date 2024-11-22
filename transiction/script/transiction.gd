extends Node2D

@onready var animation_player = $CanvasLayer/TransictionScene/AnimationPlayer

func _ready() -> void:
	hide()
	animation_player.stop()

func fade_out() -> void:
	show()
	animation_player.play("fade_out")

func fade_in() -> void:
	show()
	animation_player.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	hide()
	if anim_name == "fade_in":
		EventSystem.transition_fade_in_end.emit()
	elif anim_name == "fade_out":
		EventSystem.transition_fade_out_end.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()
