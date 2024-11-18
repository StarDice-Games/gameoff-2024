extends Area2D

@export var direction: String = "left"

func _ready():
	add_to_group("Checkpoints")
