extends Node2D

@export var first_tasks : Array[Task]
@export var second_tasks : Array[Task]

@export var dialog_player : Array[DialogText]

var second_task_loaded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("act_1", false):
		TriggersSystem.update_trigger("ring", true)
	
	# Prima chiamata con il boss e task NPC
	if first_tasks.size() != 0:
		if first_tasks[0].current_counter == first_tasks[0].counter_max:
			first_tasks.clear()
			TriggersSystem.update_trigger("act_2", true)
			TriggersSystem.update_trigger("ring", true)
	
	if TriggersSystem.check_trigger("act_3", true):
		TriggersSystem.update_trigger("ring", true)
	
	if second_tasks[0].complete and second_tasks[1].complete and second_tasks[2].complete and TriggersSystem.check_trigger("act_4", false):
		TriggersSystem.update_trigger("act_4", true)
		TriggersSystem.update_trigger("ring", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TriggersSystem.check_trigger("first_boss_call", true):
		TaskSystem.load_tasks(first_tasks)
		TriggersSystem.update_trigger("place_npc", true)
		TriggersSystem.update_trigger("first_boss_call", false)
	
	if TriggersSystem.check_trigger("close_museum", true):
		LevelSystem.load_level("close_museum_cutscene", true)
		
	if TriggersSystem.check_trigger("dialog_player", true):
		DialogueSystem.start_dialog(dialog_player)
		TriggersSystem.update_trigger("dialog_player", false)
		
	if TriggersSystem.check_trigger("second_boss_call", true):
		TaskSystem.load_tasks(second_tasks)
		TriggersSystem.update_trigger("second_boss_call", false)
		TriggersSystem.update_trigger("act_3", false)
		
	if Input.is_action_just_pressed("debug_kev1"):
		first_tasks[0].current_counter = 4
	
	if Input.is_action_just_pressed("debug_kev2"):
		second_tasks[0].complete = true
		second_tasks[1].complete = true
		second_tasks[2].complete = true
	
