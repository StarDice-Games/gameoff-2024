extends Node2D

@export var task_ui : PackedScene
@onready var container = $CanvasLayer/Control/Panel/VBoxContainer

var task_map = {}
#var task_list : Array[Task]

var all_complete : bool = false
@onready var ui = $CanvasLayer/Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.task_completed.connect(task_completed)
	EventSystem.task_update.connect(update_task_counter)
	
	hide_task_list()
	EventSystem.cutscene_started.connect(hide_task_list)
	EventSystem.cutscene_finished.connect(show_task_list)

func load_tasks(task_list : Array[Task]):
	
	all_complete = false
	
	if task_list.size() > 0:
		show_task_list()
	
	if container.get_child_count() > 0 :
		for child in container.get_children():
			container.remove_child(child)
			child.queue_free()
		task_map.clear()
	
	for task in task_list:
		var task_design = task_ui.instantiate()
		container.add_child(task_design)
		task_design.set_ui(task)
		
		task_map[task.id] = {
			"data" :task,
			"ui" : task_design
		}

func task_completed(task_id : String) :
	
	if not task_map.has(task_id) :
		printerr("Task completed ", task_id, " not found.")
		return
	var task = task_map[task_id]
	task["data"].complete = true
	task["ui"].set_ui(task["data"])
	
	#check if all task are complete
	if check_all_task_completed() :
		EventSystem.all_task_completed.emit()

func update_task_counter(task_id : String) :
	if not task_map.has(task_id) :
		printerr("Task update ", task_id, " not found.")
		return
	var task = task_map[task_id]
	var task_data = task["data"]
	task_data.current_counter += 1
	
	task["ui"].update_counter(task_data)
	
	if task_data.current_counter >= task_data.counter_max:
		EventSystem.task_completed.emit(task_id)

func check_all_task_completed():
	for key in task_map:
		if task_map[key]["data"].complete == false:
			return false
	return true

func show_task_list():
	ui.show()

func hide_task_list():
	ui.hide()
