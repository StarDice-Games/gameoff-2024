extends Node2D

@export var item : ItemData
@onready var label_interact = $Label


func _on_interactable_player_enter() -> void:
	label_interact.show()


func _on_interactable_player_exit() -> void:
	label_interact.hide()


func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	TriggersSystem.toggle_trigger("rope_picked")
