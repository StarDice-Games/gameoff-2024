extends Node2D

@export var first_tasks : Array[Task]

var close_museum = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("first_boss_call", false):
		TriggersSystem.update_trigger("ring", true)
	
	if first_tasks[0].current_counter == first_tasks[0].counter_max:
		TriggersSystem.update_trigger("act_2", true)
		TriggersSystem.update_trigger("ring", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TriggersSystem.check_trigger("first_boss_call", true):
		TaskSystem.load_tasks(first_tasks)
	
	if TriggersSystem.check_trigger("close_museum", true):
		LevelSystem.load_level("close_museum_cutscene", true)
		
	if Input.is_action_just_pressed("debug_kev"):
		first_tasks[0].current_counter = 4
	
