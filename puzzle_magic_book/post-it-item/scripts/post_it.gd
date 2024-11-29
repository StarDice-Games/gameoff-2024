extends Node2D

@export var item : ItemData
@export var picked_up : String = "post-it_picked"
@onready var label = $Label
@export var dialog : Array[DialogText]

func _ready() -> void:
	label.hide()
	if TriggersSystem.check_trigger(picked_up, true):
		hide()
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		queue_free()

func _on_interactable_interacted() -> void:	
	print("player interaction with", name)
	InventorySystem.pick_up(item)
	TriggersSystem.update_trigger(picked_up, true)
	DialogueSystem.start_dialog(dialog)
	queue_free()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _on_interactable_player_enter() -> void:
	label.show()
	print("player entered", name)


func _on_interactable_player_exit() -> void:
	label.hide()
	print("player exit", name)
