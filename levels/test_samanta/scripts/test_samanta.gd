extends Node2D

func _ready() -> void:
	EventSystem.transition_fade_out_end.connect(animation_end)
	TriggersSystem.update_trigger("ring", true)

func animation_end():
	LevelSystem.load_level("Test Simon")

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body == %Player:
		#TransictionScene.fade_out()
