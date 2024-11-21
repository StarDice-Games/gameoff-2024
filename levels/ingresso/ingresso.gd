extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_counter_talk)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk0" and value == true:
		EventSystem.task_update.emit("first_tasks")
	
	if key == "pulled_out" and value == true:
		$FallingToothAnim/AnimationPlayer.play("fallling_tooth")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()
