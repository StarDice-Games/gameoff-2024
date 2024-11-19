extends CharacterBody2D
@onready var talk_prompt = $Label
@export var dialog : Array[DialogText]

func _ready() -> void:
	if TriggersSystem.check_trigger("boss_talked", true):
		$Interactable.queue_free()

func _on_interactable_player_enter() -> void:
	talk_prompt.show()


func _on_interactable_player_exit() -> void:
	talk_prompt.hide()


func _on_interactable_interacted() -> void:
	EventSystem.cutscene_started.emit()
	talk_prompt.hide()
	DialogueSystem.start_dialog(dialog)
	TriggersSystem.update_trigger("boss_talked", true)
	$Interactable.queue_free()
