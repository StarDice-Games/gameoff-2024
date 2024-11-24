extends Node2D

@onready var interact_prompt = $Label
@onready var collision_hide = $StaticBody2D/Interactable

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]
@export var dialog_4 : Array[DialogText]
@export var act : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#EventSystem.trigger_changed.connect(trigger_update)
	#if TriggersSystem.check_trigger("ring", true):
		#EventSystem.ring_phone.emit("Phone_Ring")

#func trigger_update(key, value):
	#if key == "ring" and value == true:
		#EventSystem.ring_phone.emit("Phone_Ring")
	
func _on_interactable_player_enter() -> void:
	if TriggersSystem.check_trigger("ring", true):
		interact_prompt.show()

func _on_interactable_player_exit() -> void:
	if TriggersSystem.check_trigger("ring", true):
		interact_prompt.hide()

func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("ring", true):
		TriggersSystem.update_trigger("ring", false)
		#EventSystem.stop_ring_phone.emit()
		interact_prompt.hide()
		collision_hide.hide()
		EventSystem.cutscene_started.emit()
		TriggersSystem.update_trigger(act, true)
		start_dialog()

func start_dialog():
	AudioSystem.play_audio_event("Phone_Answer", "Sfx")
	
	await get_tree().create_timer(1).timeout
	if TriggersSystem.check_trigger("act_1", true):
		DialogueSystem.start_dialog(dialog_1)
		
	if TriggersSystem.check_trigger("act_2", true):
		DialogueSystem.start_dialog(dialog_2)
		
	if TriggersSystem.check_trigger("act_3", true):
		DialogueSystem.start_dialog(dialog_3)
	
	if TriggersSystem.check_trigger("act_4", true):
		DialogueSystem.start_dialog(dialog_4)
