extends Node2D

@export var first_tasks : Array[Task]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("first_boss_call", false):
		TriggersSystem.update_trigger("ring", true)
	
	if first_tasks[0].current_counter == first_tasks[0].counter_max:
		TriggersSystem.update_trigger("ring", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TriggersSystem.check_trigger("first_boss_call", true):
		TaskSystem.load_tasks(first_tasks)
	
