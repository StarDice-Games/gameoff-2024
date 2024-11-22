extends Node2D

@export var dialog1 : Array[DialogText]
@export var dialog2 : Array[DialogText]

func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	TriggersSystem.update_trigger("doors_locked", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger_update(key, value):	
	if key == "boss_exit" and value == true:
		$AnimationPlayer.play("boss_walk")
	
	if key == "stealth" and value == true:
		DialogueSystem.start_dialog(dialog2)
	
	if key == "stealth" and value == true:
		TriggersSystem.update_trigger("doors_locked", false)
		
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	DialogueSystem.start_dialog(dialog1)


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()
