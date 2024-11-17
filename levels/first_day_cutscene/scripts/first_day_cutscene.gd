extends Node2D

@export var dialog_1 : Array[DialogText]
@export var dialog_2 : Array[DialogText]
@export var dialog_3 : Array[DialogText]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if DialogueSystem.started == false and $Timer.is_stopped():
		$AnimationPlayer.play("walk_inside")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	LevelSystem.load_level("guardiola", true)

func _on_timer_timeout() -> void:
	DialogueSystem.start_dialog(dialog_1)
