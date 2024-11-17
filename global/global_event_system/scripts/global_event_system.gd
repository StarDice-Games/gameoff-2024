extends Node2D

signal task_completed(task_id : String)
signal task_update(task_id : String)
signal all_task_completed()

#TOOO this should be moved insiede the audio system
signal set_volume(bus : String, volume : float)
signal play_sound(audio_key : String, bus : String)
signal play_music(audio_key : String)

#inventory
signal picked_up_item(item_id : String)
signal dropped_item(item_id : String)
signal  transition_fade_in_end
signal  transition_fade_out_end

#UI
signal hide_hud()
signal show_hud()

signal cutscene_started()
signal cutscene_finished()

#Triggers
signal trigger_changed(key : String, value : bool)
