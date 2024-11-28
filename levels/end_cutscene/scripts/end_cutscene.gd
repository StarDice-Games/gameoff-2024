extends Node2D

var sfx : AudioStream = load("res://audio/sfx/various/Police_Siren_01.wav")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	#$Timer.start()
	AudioSystem.play(sfx)
	
func move_to_credits():
	LevelSystem.load_level("credits", true)
	
#func _on_timer_timeout() -> void:
	#LevelSystem.load_level("credits", true)
