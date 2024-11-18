extends Node2D

@onready var label_pick_up = $Label
@export var item : ItemData
@export var task : Task

func _on_interactable_player_enter() -> void:
	label_pick_up.show()


func _on_interactable_player_exit() -> void:
	label_pick_up.hide()


func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	TaskSystem.task_completed(task.id)
	queue_free()
