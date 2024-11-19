extends CharacterBody2D

@export var dialog1 : Array[DialogText]
@export var dialog2 : Array[DialogText]
@export var dialog3 : Array[DialogText]

@export var trigger_id : String

@onready var prompt_label = $Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_kev1"):
		TriggersSystem.update_trigger("ritual_object_placed", true)

func _on_interactable_player_enter() -> void:
		prompt_label.show()

func _on_interactable_player_exit() -> void:
	prompt_label.hide()

func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger(trigger_id, true):
		DialogueSystem.start_dialog(dialog2)
	else:
		DialogueSystem.start_dialog(dialog1)
		TriggersSystem.update_trigger(trigger_id, true)
		
	if TriggersSystem.check_trigger("ritual_object_placed", true):
		DialogueSystem.start_dialog(dialog3)
		
