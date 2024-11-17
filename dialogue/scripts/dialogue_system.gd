extends Node2D

@onready var dialogue_box = $CanvasLayer/Control
@onready var text_label = $CanvasLayer/Control/DialogueBox/DialogueText
@onready var image_character = $CanvasLayer/Control/DialogueBox/Panel/Character
@onready var name_character = $CanvasLayer/Control/DialogueBoxName/DialogueName

@export var speed_text : float
var dialogs : Array[DialogText] = []

var text_index = 0
var dialog_index = 0
var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_box.hide()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not started :
		return
	
	if text_label.visible_ratio < 1:
		text_label.visible_characters += speed_text

	if Input.is_action_just_pressed("interact"):
		if text_label.visible_ratio < 1:
			text_label.visible_characters = -1
		elif text_label.visible_ratio >= 1:
			if text_index < dialogs[dialog_index].dialogue_text.size() - 1:
				text_index += 1
				text_label.text = dialogs[dialog_index].dialogue_text[text_index]
				text_label.visible_characters = 0
				text_label.visible_ratio = 0
			else:
				next_dialog()

func start_dialog(dialog : Array[DialogText]):
	dialogue_box.show()
	self.dialogs = dialog
	text_index = 0
	dialog_index = 0
	text_label.text = dialogs[dialog_index].dialogue_text[text_index]
	name_character.text = dialogs[dialog_index].text_name
	image_character.texture = dialogs[dialog_index].character_image
	text_label.visible_characters = 0
	text_label.visible_ratio = 0
	started = true
	EventSystem.cutscene_started.emit()

func next_dialog():
	if dialog_index < dialogs.size() - 1:
		#set all the triggers, for the current one
		var dialog_triggers = dialogs[dialog_index].triggers
		if  dialog_triggers != null and dialog_triggers.size() > 0:
			for trigger in dialog_triggers:
				TriggersSystem.update_trigger(trigger.key, trigger.value)
		
		dialog_index += 1
		text_index = 0
		text_label.text = dialogs[dialog_index].dialogue_text[text_index]
		name_character.text = dialogs[dialog_index].text_name
		image_character.texture = dialogs[dialog_index].character_image
		text_label.visible_characters = 0
		text_label.visible_ratio = 0
		
	else:
		dialogue_box.hide()
		started = false
		EventSystem.cutscene_finished.emit()
