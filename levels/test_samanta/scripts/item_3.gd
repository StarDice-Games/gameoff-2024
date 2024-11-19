extends Node2D
@export var item : ItemData


func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	hide()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	


func _on_interactable_player_enter() -> void:
	$Label2.show()


func _on_interactable_player_exit() -> void:
	$Label2.hide()
