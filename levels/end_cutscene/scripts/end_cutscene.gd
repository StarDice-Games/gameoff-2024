extends Node2D

var sfx : AudioStream = load("res://audio/sfx/various/Police_Siren_01.wav")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	#$Timer.start()
	EventSystem.play_music.emit("Police_Siren_01")
	EventSystem.stop_sound.emit("go2024_stealth_v1")

	
func move_to_credits():
	LevelSystem.load_level("credits", true)
	
#func _on_timer_timeout() -> void:
	#LevelSystem.load_level("credits", true)
