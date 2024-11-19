extends Node2D
@export var item : ItemData

func _ready() -> void:
	if TriggersSystem.check_trigger("rope_picked", true):
		hide()
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	TriggersSystem.update_trigger("rope_picked", true)
	hide()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	
