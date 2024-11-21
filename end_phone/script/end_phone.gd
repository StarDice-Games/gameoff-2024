extends Node2D

@export var dialog : Array[DialogText]

@onready var interactable: Interactable = $Interactable
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	AudioSystem.mute
	$AnimationPlayer.play("dial")
	$Interactable.queue_free()

func _on_interactable_player_enter() -> void:
	label.show()


func _on_interactable_player_exit() -> void:
	label.hide()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	EventSystem.cutscene_finished.emit()
	DialogueSystem.start_dialog(dialog)
