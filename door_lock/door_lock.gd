extends Area2D

@export var dialog : Array[DialogText]

@onready var trigger: CollisionShape2D = $Trigger
@onready var collision_shape_2d_2: CollisionShape2D = $StaticBody2D/CollisionShape2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_trigger)
	if TriggersSystem.check_trigger("doors_locked", false):
		trigger.disabled = true
		collision_shape_2d_2.disabled = true

func update_trigger(key: String, value : bool) -> void:
	if key == "doors_locked" and value == true:
		trigger.disabled = false
		collision_shape_2d_2.disabled = false
	
	if key == "doors_locked" and value == false:
		trigger.disabled = true
		collision_shape_2d_2.disabled = true

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if TriggersSystem.check_trigger("doors_locked", true):
		AudioSystem.play_audio_event("Locked_Door_01", "Sfx")
		DialogueSystem.start_dialog(dialog)
