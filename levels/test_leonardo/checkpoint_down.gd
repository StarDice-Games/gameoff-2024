extends Area2D

@export var direction: String = "down"

func _ready():
	add_to_group("Checkpoints")
