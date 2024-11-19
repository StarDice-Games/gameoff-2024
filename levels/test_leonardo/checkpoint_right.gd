extends Area2D

@export var direction: String = "right"

func _ready():
	add_to_group("Checkpoints")
