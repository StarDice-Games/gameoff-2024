extends Area2D

@export var dialog : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if TriggersSystem.check_trigger("stealth", true):
		DialogueSystem.start_dialog(dialog)
