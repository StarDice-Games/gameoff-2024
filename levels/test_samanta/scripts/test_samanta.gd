extends Node2D

@export var task : Array[Task]
func _ready() -> void:
	TaskSystem.load_tasks(task)
