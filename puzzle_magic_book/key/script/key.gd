extends Node2D

@onready var label: Label = $Label
@export var item : ItemData
@export var dialog : Array[DialogText]

func _on_interactable_player_enter() -> void:
	label.show()


func _on_interactable_player_exit() -> void:
	label.hide()


func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	DialogueSystem.start_dialog(dialog)
	TriggersSystem.toggle_trigger("key_picked")
	queue_free()
