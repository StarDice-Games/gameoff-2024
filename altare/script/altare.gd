extends Node2D

@onready var label: Label = $Label
@onready var sprite_object: Sprite2D = $Sprite_object
@onready var sprite_empty: Sprite2D = $Sprite_empty
@onready var interactable: Interactable = $Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TriggersSystem.check_trigger("ritual_objects_placed", true):
		sprite_empty.hide()
		sprite_object.show()
		interactable.queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("talk_boss", true):
		sprite_empty.hide()
		sprite_object.show()
		TriggersSystem.toggle_trigger("ritual_objects_placed")
		interactable.queue_free()
		label.hide()

func _on_interactable_player_enter() -> void:
	if TriggersSystem.check_trigger("talk_boss", true):
		label.show()


func _on_interactable_player_exit() -> void:
	label.hide()
