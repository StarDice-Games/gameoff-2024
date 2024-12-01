class_name MainMenu
extends UIState

@onready var main_panel = $MainPanel
#@onready var load_button :Button = $MainPanel/VBoxContainer/LoadGame
@onready var new_game_button : Button = $MainPanel/VBoxContainer/NewGame
@onready var exit_button : Button = $MainPanel/VBoxContainer/Exit
#@export var menu_music : String

var music_off = false
var sfx_off = false

func init(_state_machine: UIStateMachine) -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	
	state_machine = _state_machine
	if Input.get_connected_joypads().size() > 0:
		new_game_button.grab_focus()
	#AudioSystem.play_music_event(menu_music)

func _on_joy_connection_changed(device_id, connected):
	if Input.get_connected_joypads().size() > 0:
		new_game_button.grab_focus()
	else:
		new_game_button.release_focus()

		
func enter(_msg := {}) -> void:
	main_panel.show()
	#EventSystem.play_music.emit("sc_mx_title_v4")
	#load_button.disabled = not SaveSystem.find_save_game();

func exit() -> void:
	main_panel.hide()


func _on_settings_pressed():
	AudioSystem.play_audio_event("UI_Button_Click_01", "Sfx")
	state_machine.change_state("Settings")

func _on_exit_pressed():
	AudioSystem.play_audio_event("UI_Button_Click_01", "Sfx")
	get_tree().quit()


func _on_new_game_pressed() -> void:
	TriggersSystem.reset()
	TriggersSystem.toggle_trigger("not_in_title")
	AudioSystem.play_audio_event("UI_Button_Click_01", "Sfx")
	EventSystem.cutscene_started.emit()
	get_viewport().gui_release_focus()
	

func _on_load_game_pressed():
	pass
	#SaveSystem.load_game()
	#LevelSystem.load_level("level_1")


func _on_new_game_mouse_entered() -> void:
	AudioSystem.play_audio_event("UI_Highlight_Selection_04", "Sfx")


func _on_settings_mouse_entered() -> void:
	AudioSystem.play_audio_event("UI_Highlight_Selection_04", "Sfx")


func _on_exit_mouse_entered() -> void:
	AudioSystem.play_audio_event("UI_Highlight_Selection_04", "Sfx")


func _on_music_pressed() -> void:
	if !music_off:
		music_off = true
		AudioSystem.set_volumes_value("Music", -80)
	else:
		music_off = false
		AudioSystem.set_volumes_value("Music", 0)


func _on_sfx_pressed() -> void:
	if !sfx_off:
		sfx_off = true
		AudioSystem.set_volumes_value("Sfx", -80)
	else:
		sfx_off = false
		AudioSystem.set_volumes_value("Sfx", 0)
