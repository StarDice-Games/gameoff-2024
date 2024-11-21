extends Node2D

@export var dialog : Array[DialogText]

@onready var interactable: Interactable = $Interactable
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	DialogueSystem.start_dialog(dialog)

func _on_interactable_player_enter() -> void:
	label.show()


func _on_interactable_player_exit() -> void:
	label.hide()
