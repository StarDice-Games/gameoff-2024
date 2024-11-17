extends Node2D

@export var item : ItemData

@onready var label = $Label

func _ready() -> void:
	label.hide()

func _on_interactable_interacted() -> void:
	print("player interaction with", name)
	InventorySystem.pick_up(item)
	hide()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _on_interactable_player_enter() -> void:
	label.show()
	print("player entered", name)


func _on_interactable_player_exit() -> void:
	label.hide()
	print("player exit", name)
