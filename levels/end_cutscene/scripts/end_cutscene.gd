extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Timer.start()
	AudioSystem.play_music_event("Police_Siren_01")

func _on_timer_timeout() -> void:
	LevelSystem.load_level("credits")
