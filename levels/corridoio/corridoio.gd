extends Node2D

@export var dialog_escape : Array[DialogText]
@export var alarm_sfx : AudioStream

@onready var animation_player: AnimationPlayer = $OpenPaintingCutscene/CanvasLayer/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_counter_talk)
	
	 #TriggersSystem.update_trigger("stealth", true)
		
	if TriggersSystem.check_trigger("stealth", true) and TriggersSystem.check_trigger("alarm_started", false):
		DialogueSystem.start_dialog(dialog_escape)
		TriggersSystem.update_trigger("doors_locked", true)
		AudioSystem.mute = false
		EventSystem.play_sound.emit("Alarm_01", "Sfx")
		EventSystem.play_music.emit("go2024_stealth_v1")
	
	if TriggersSystem.check_trigger("stealth", false):
		$DoorLock2.queue_free()
		$DoorLock3.queue_free()
		$Stealth.queue_free()
	else:
		$Stealth.show()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk1" and value == true:
		EventSystem.task_update.emit("first_tasks")

	if key == "opened_painting" and value == true:
		animation_player.play("open_painting")
		
func _on_door_lock_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", 0)
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 80)
	EventSystem.cutscene_started.emit()
