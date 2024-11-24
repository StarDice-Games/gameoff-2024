extends Node2D

@onready var anim_close_museum: AnimationPlayer = $CloseMuseumCutscene/CanvasLayer/AnimationPlayer
@onready var anim_open_guardaroba: AnimationPlayer = $OpenGuardarobaCutscene/CanvasLayer/AnimationPlayer
@onready var anima_end: AnimationPlayer = $EndPhone/CanvasLayer/AnimationPlayer2

@export var first_tasks : Array[Task]
@export var second_tasks : Array[Task]

@export var dialog_player : Array[DialogText]

var second_task_loaded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	TriggersSystem.update_trigger("doors_locked", true)
	
	# Prima chiamata con il boss e task NPC
	# ora quando si completano le task è il player che controlla, 
	# ma qui dobbiamo settare il trigger ring
	if TaskSystem.check_all_task_completed() and TriggersSystem.check_trigger("act_1", true):
		TriggersSystem.update_trigger("act_2", true)
		#TriggersSystem.update_trigger("ring", true)
	
	if TaskSystem.check_all_task_completed() and TriggersSystem.check_trigger("second_boss_call", true):
		TriggersSystem.update_trigger("act_4", true)
		#TriggersSystem.update_trigger("ring", true)

func trigger_update(key, value):	
	if key == "first_boss_call" and value == true:
		TaskSystem.load_tasks(first_tasks)
		TriggersSystem.update_trigger("place_npc", true)
		TriggersSystem.update_trigger("first_boss_call", false)
		
	if key == "close_museum" and value == true:
		anim_close_museum.play("close_museum")
		
	if key == "guardian_locker_open" and value == true:
		anim_open_guardaroba.play("open_guardaroba")
		
	if key == "second_boss_call" and value == true:
		TaskSystem.load_tasks(second_tasks)
		
	#suona il telefono dopo che chiude il museo ? si ma non serve
	#if key == "act_3" and value == true:
		#pass
		#TriggersSystem.update_trigger("ring", true)
	
	if key == "dialog_player" and value == true:
		DialogueSystem.start_dialog(dialog_player)
		
	if key == "end" and value == true:
		$EndPhone/DelayEndCut.start()
	
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	if Input.is_action_just_pressed("debug_kev1"):
		TriggersSystem.update_trigger("second_boss_call", true)
		TaskSystem.update_task_counter(first_tasks[0].id)
		TaskSystem.update_task_counter(first_tasks[0].id)
		TaskSystem.update_task_counter(first_tasks[0].id)
		TaskSystem.update_task_counter(first_tasks[0].id)
		#first_tasks[0].current_counter = 4
	
	if Input.is_action_just_pressed("debug_kev2"):
		second_tasks[0].complete = true
		second_tasks[1].complete = true
		second_tasks[2].complete = true
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", 0)
	#TriggersSystem.update_trigger("close_museum", false)
	#TriggersSystem.update_trigger("act_3", true)
	EventSystem.cutscene_finished.emit()
	TriggersSystem.toggle_trigger("night")
	AudioSystem.play_music_event("go2024_phase2_v2")
	LevelSystem.load_level("esterno")

#questo fa iniziare il telefono se si parte dalla guardiola, 
#in futuro si potrebbe togliere anche questo
#func _on_timer_timeout() -> void:
	#if TriggersSystem.check_trigger("act_1", false):
		#TriggersSystem.update_trigger("ring", true)


func _on_animation_player_animation_finished_guardaroba(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", 0)
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started_guardaroba(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 10)
	EventSystem.cutscene_started.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 80)
	EventSystem.cutscene_started.emit()


func _on_delay_anim_timeout() -> void:
	anim_close_museum.play("close_museum")


func _on_delay_end_cut_timeout() -> void:
	anima_end.play("end")


func _on_animation_player_2_animation_finished_end(anim_name: StringName) -> void:
	LevelSystem.load_level("end scene", true)


func _on_animation_player_2_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()
