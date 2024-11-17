extends Node2D

@export var test_list_task : Array[Task]
@export var second_list_task : Array[Task]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TaskSystem.load_tasks(test_list_task)
	EventSystem.picked_up_item.connect(item_picked_up)
	EventSystem.trigger_changed.connect(update_counter_talk)

func item_picked_up(item_id : String):
	if item_id == "Mouse" :
		TaskSystem.load_tasks(second_list_task)

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk1" and value == true:
		EventSystem.task_update.emit("test_counter")
	if key == "trigger_from_dialog" and value == true:
		print_debug("Trigger is true from dialog")
