extends Node2D

@export var dialog_pixel : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("stealth", true):
		DialogueSystem.start_dialog(dialog_pixel)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
