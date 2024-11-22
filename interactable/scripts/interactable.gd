extends Node
class_name Interactable

signal interacted
signal player_enter
signal player_exit

@export var audio_sfx = AudioStream

func interact() :
	interacted.emit()
	AudioSystem.play(audio_sfx)

func player_enter_trigger() :
	player_enter.emit()
	
func player_exit_trigger() :
	player_exit.emit()
