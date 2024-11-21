extends Node2D

@export var dialog_escape : Array[DialogText]
@export var alarm_sfx : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_counter_talk)
	
	if TriggersSystem.check_trigger("stealth", true):
		DialogueSystem.start_dialog(dialog_escape)
		TriggersSystem.update_trigger("doors_locked", true)
		AudioSystem.play(alarm_sfx)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk1" and value == true:
		EventSystem.task_update.emit("first_tasks")

	if key == "opened_painting" and value == true:
		$OpenPaintingCutscene/AnimationPlayer.play("open_painting")
		
func _on_door_lock_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()
