extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Timer.start()
	EventSystem.play_sound.emit("Police_Siren_01", "sfx")

func _on_timer_timeout() -> void:
	LevelSystem.load_level("credits")
