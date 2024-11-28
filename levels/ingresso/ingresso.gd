extends Node2D

@onready var animation_player: AnimationPlayer = $FallingToothAnim/CanvasLayer/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_counter_talk)
	
	#TriggersSystem.update_trigger("stealth", true)
		
	if TriggersSystem.check_trigger("stealth", true):
		$Stealth.show()
		return
	else:
		$Stealth.queue_free()
	
	if TriggersSystem.check_trigger("from_exit", true):
		if TriggersSystem.check_trigger("night", true):
			AudioSystem.play_music_event("go2024_phase2_v3")
			TriggersSystem.toggle_trigger("from_exit")
		else:
			AudioSystem.play_music_event("go2024_phase1_v1")
			TriggersSystem.toggle_trigger("from_exit")
	
	if TriggersSystem.check_trigger("act_3", true):
		if TriggersSystem.check_trigger("second_boss_call", false):
			TriggersSystem.update_trigger("ring", true)

	#if TriggersSystem.check_trigger("stealth", true):
	#	AudioSystem.play_music_event("go2024_stealth_v1")
	#
	if TriggersSystem.check_trigger("act_1", false):
		TriggersSystem.update_trigger("ring", true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk0" and value == true:
		EventSystem.task_update.emit("first_tasks")
	
	if key == "pulled_out" and value == true:
		animation_player.play("fallling_tooth")
	
	if key == "ring" and value == true:
		$VignettaTelefono.show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", 0)
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 80)
	EventSystem.cutscene_started.emit()
	
