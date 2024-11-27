extends Node2D

@onready var animation_player: AnimationPlayer = $FishCutScene/CanvasLayer/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(update_counter_talk)
	
	if TriggersSystem.check_trigger("rope_taken", true):
		$Stanze/PesceLuna.hide()
		$Stanze/PesceSchiantato.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_counter_talk(key: String, value : bool) -> void:
	if key == "talk2" and value == true:
		EventSystem.task_update.emit("first_tasks")
	
	if key == "rope_taken" and value == true:
		animation_player.play("falling_fish")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", 0)
	EventSystem.cutscene_finished.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 80)
	$Stanze/PesceLuna.hide()
	$Stanze/PesceSchiantato.show()
	EventSystem.cutscene_started.emit()
