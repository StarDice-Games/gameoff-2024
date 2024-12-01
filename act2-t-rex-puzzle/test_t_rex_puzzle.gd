extends Node2D

@export var task_list : Array[Task]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TaskSystem.load_tasks(task_list)
