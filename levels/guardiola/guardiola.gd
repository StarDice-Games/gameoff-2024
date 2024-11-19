extends Node2D

@export var first_tasks : Array[Task]
@export var second_tasks : Array[Task]

@export var dialog_player : Array[DialogText]

var second_task_loaded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	TriggersSystem.update_trigger("doors_locked", true)
		
	if TriggersSystem.check_trigger("act_1", false):
		TriggersSystem.update_trigger("ring", true)
	
	# Prima chiamata con il boss e task NPC
	if TaskSystem.check_all_task_completed() and TriggersSystem.check_trigger("act_1", true):
		TriggersSystem.update_trigger("act_2", true)
		TriggersSystem.update_trigger("ring", true)
	
	if TaskSystem.check_all_task_completed() and TriggersSystem.check_trigger("second_boss_call", true):
		TriggersSystem.update_trigger("act_4", true)
		TriggersSystem.update_trigger("ring", true)

func trigger_update(key, value):	
	if key == "first_boss_call" and value == true:
		TaskSystem.load_tasks(first_tasks)
		TriggersSystem.update_trigger("place_npc", true)
		TriggersSystem.update_trigger("first_boss_call", false)
		
	if key == "close_museum" and value == true:
		$CloseMuseumCutscene/AnimationPlayer.play("close_museum")
		
	if key == "second_boss_call" and value == true:
		TaskSystem.load_tasks(second_tasks)
		
	if key == "act_3" and value == true:
		TriggersSystem.update_trigger("ring", true)
	
	if key == "dialog_player" and value == true:
		DialogueSystem.start_dialog(dialog_player)
	
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	if Input.is_action_just_pressed("debug_kev1"):
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
	TriggersSystem.update_trigger("close_museum", false)
	TriggersSystem.update_trigger("act_3", true)


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	InventorySystem.hide_inventory()
	TaskSystem.hide_task_list()
