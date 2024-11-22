extends Node2D

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TriggersSystem.update_trigger("doors_locked", true)
	
	if TriggersSystem.check_trigger("start", false):
		DialogueSystem.start_dialog(dialog_1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
