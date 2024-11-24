extends Node2D

@export var dialog_1 : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("close_museum", true):
		$Node2D/AnimationPlayer.play("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TriggersSystem.update_trigger("close_museum", false)
	TriggersSystem.update_trigger("act_3", true)
	DialogueSystem.start_dialog(dialog_1)
