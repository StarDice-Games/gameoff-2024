extends Node2D

@export var task : Array[Task]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TaskSystem.load_tasks(task)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
