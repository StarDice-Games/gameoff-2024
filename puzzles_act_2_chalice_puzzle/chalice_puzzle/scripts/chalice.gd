extends Node2D

@onready var label: Label = $Label
@export var item : ItemData
@export var dialog : Array[DialogText]
@export var task : Task

func _on_interactable_player_enter() -> void:
	label.show()


func _on_interactable_player_exit() -> void:
	label.hide()


func _on_interactable_interacted() -> void:
	if visible:
		InventorySystem.pick_up(item)
		TriggersSystem.update_trigger("chalice_picked", true)
		TaskSystem.task_completed(task.id)
		DialogueSystem.start_dialog(dialog)
		queue_free()
