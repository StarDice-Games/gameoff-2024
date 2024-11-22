class_name MainMenu
extends UIState

@onready var main_panel = $MainPanel
@onready var load_button :Button = $MainPanel/VBoxContainer/LoadGame

#@export var menu_music : String

func init(_state_machine: UIStateMachine) -> void:
	state_machine = _state_machine
	#AudioSystem.play_music_event(menu_music)

func enter(_msg := {}) -> void:
	main_panel.show()
	#EventSystem.play_music.emit("sc_mx_title_v4")
	#load_button.disabled = not SaveSystem.find_save_game();

func exit() -> void:
	main_panel.hide()


func _on_settings_pressed():
	state_machine.change_state("Settings")

func _on_exit_pressed():
	get_tree().quit()


func _on_new_game_pressed() -> void:
	LevelSystem.load_level("esterno", true)
	EventSystem.cutscene_started.emit()
	EventSystem.show_hud.emit()

func _on_load_game_pressed():
	pass
	#SaveSystem.load_game()
	#LevelSystem.load_level("level_1")
