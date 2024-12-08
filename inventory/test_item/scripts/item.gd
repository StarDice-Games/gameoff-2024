extends Node2D

@export var dialog : Array[DialogText]
var dialog_start = false

var press_start = false


func _on_interactable_player_enter() -> void:
	press_start = true
	$Label.show()


func _on_interactable_player_exit() -> void:
	press_start = false
	$Label.hide()


func _on_interactable_interacted() -> void:
	DialogueSystem.start_dialog(dialog)
