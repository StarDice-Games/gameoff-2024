extends Node2D

@onready var label_pick_up = $Label
@export var item : ItemData
@export var dialog : Array[DialogText]
@export var task : Task

func _on_interactable_player_enter() -> void:
	label_pick_up.show()


func _on_interactable_player_exit() -> void:
	label_pick_up.hide()


func _on_interactable_interacted() -> void:
	if visible:
		InventorySystem.pick_up(item)
		TriggersSystem.update_trigger("got_magic_book", true)
		TaskSystem.task_completed(task.id)
		DialogueSystem.start_dialog(dialog)
		queue_free()
