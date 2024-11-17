extends Node2D

@onready var interact_prompt = $Label
@onready var ring_sound = $Ring
@onready var hang_sound = $Hang
@onready var collision_hide = $StaticBody2D/Interactable

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]
@export var act : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("ring", true):
		ring_sound.play()
	$Timer.start()

func _on_interactable_player_enter() -> void:
	if TriggersSystem.check_trigger("ring", true):
		interact_prompt.show()

func _on_interactable_player_exit() -> void:
	if TriggersSystem.check_trigger("ring", true):
		interact_prompt.hide()

func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("ring", true):
		ring_sound.stop()
		interact_prompt.hide()
		collision_hide.hide()
		EventSystem.cutscene_started.emit()
		TriggersSystem.update_trigger("ring", false)
		TriggersSystem.update_trigger(act, true)
		start_dialog()

func start_dialog():
	hang_sound.play()
	await get_tree().create_timer(1).timeout
	if TriggersSystem.check_trigger("act_1", true):
		DialogueSystem.start_dialog(dialog_1)
		
	if TriggersSystem.check_trigger("act_2", true):
		DialogueSystem.start_dialog(dialog_2)
		
	if TriggersSystem.check_trigger("act_3", true):
		DialogueSystem.start_dialog(dialog_3)


func _on_timer_timeout() -> void:
	if TriggersSystem.check_trigger("ring", true):
		$Timer.wait_time = 3.0
		ring_sound.play()
		$Timer.start()
	else:
		ring_sound.stop()
