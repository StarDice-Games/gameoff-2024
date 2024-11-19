extends Area2D

@export var direction: String = "up"

func _ready():
	add_to_group("Checkpoints")
