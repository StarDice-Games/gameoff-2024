extends Node2D

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]

@export var first_tasks : Array[Task]
@export var second_tasks : Array[Task]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Player/Camera2D.enabled = false
	
	EventSystem.trigger_changed.connect(trigger_update)
	
	$AudioStreamPlayer2D.play()
	
	TriggersSystem.update_trigger("doors_locked", true)
	
	first_tasks[0].current_counter = 0
	first_tasks[0].complete = false
	second_tasks[0].complete = false
	second_tasks[1].complete = false
	second_tasks[2].complete = false

func trigger_update(key: String, value : bool) -> void:
	if key == "not_in_title" and value == true:
		$AnimationPlayer.play("hide_title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if TriggersSystem.check_trigger("not_in_title", true):
		AudioSystem.play_music_event("Traffic_01")
		if TriggersSystem.check_trigger("start", false):
			$CameraFollow.player_ref = %Player
			DialogueSystem.start_dialog(dialog_1)


func _on_music_start_body_entered(body: Node2D) -> void:
	EventSystem.stop_sound.emit("go2024_briefing")
	AudioSystem.play_music_event("go2024_phase1_v1")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	pass


func _on_timer_timeout() -> void:
	pass
