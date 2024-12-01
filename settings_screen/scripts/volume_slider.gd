class_name VolumeSlider
extends Control

@export var audio_channel : String
@export var label_name : String

@onready var slider = $HSlider
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.set_volume.connect(set_volumes_value)
	if slider:
		AudioSystem.set_starting_ui_volume()
	
	if label_name:
		label.text = label_name
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_volumes_value(channel, value):
	print("set_volume_value slider")
	if slider and channel == audio_channel:
		slider.value = value

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed :
		EventSystem.set_volume.emit(audio_channel, slider.value)
