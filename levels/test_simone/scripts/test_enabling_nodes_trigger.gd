extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_trigger") :
		TriggersSystem.toggle_trigger("act_1")
		print("act_1:", TriggersSystem.triggers["act_1"])
