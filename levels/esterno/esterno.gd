extends Node2D

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	TriggersSystem.update_trigger("doors_locked", true)

func trigger_update(key: String, value : bool) -> void:
	if key == "not_in_title" and value == true:
		$AnimationPlayer.play("hide_title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if TriggersSystem.check_trigger("not_in_title", true):
		if TriggersSystem.check_trigger("start", false):
			DialogueSystem.start_dialog(dialog_1)
