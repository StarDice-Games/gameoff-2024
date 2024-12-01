extends Control


#Sfx
func _on_button_pressed() -> void:
	AudioSystem.play_audio_event("sfx_lvl_start", "")
	pass # Replace with function body.

#Bgm
func _on_button_2_pressed() -> void:
	AudioSystem.play_music_event("ev_mx_hub_v2")
	pass # Replace with function body.


func _on_test_level_pressed() -> void:
	LevelSystem.load_level("Test Level", false)
	pass # Replace with function body.
