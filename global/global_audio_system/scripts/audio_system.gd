extends Node

@export var num_players = 8
@export var bus = "Sfx"
@export var mute = false
@export var master_volume = 0
@export var music_volume = 0
@export var sfx_volume = 0

@export var audio_directory : String
var audio_files : Dictionary

var available = []  # The available players.
#TODO fix how the queue is managed
var queue = []  # The queue of sounds to play.
var music_player : AudioStreamPlayer

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		p.connect("finished", _on_stream_finished)
		p.bus = bus
		add_child(p)
		available.append(p)
	
	#a Bg Music Player
	music_player = AudioStreamPlayer.new()
	music_player.connect("finished", music_player_ended)
	music_player.bus = "Music"
	add_child(music_player)
	
	if not audio_directory.is_empty():
		dir_contents(audio_directory)
	
	for key in audio_files:
		print("Audio name:", key, ",file:", audio_files[key])
	
	EventSystem.play_sound.connect(play_audio_event)
	EventSystem.stop_sound.connect(stop_audio_event)
	EventSystem.play_music.connect(play_music_event)
	
	#Volume management -60 dB and 0 dB.
	#TODO load settings from user prefs
	
	EventSystem.set_volume.connect(set_volumes_value)
	
	EventSystem.set_volume.emit("Master", master_volume)
	EventSystem.set_volume.emit("Music", music_volume)
	EventSystem.set_volume.emit("Sfx", sfx_volume)

func set_starting_ui_volume() -> void:
	EventSystem.set_volume.emit("Master", master_volume)
	EventSystem.set_volume.emit("Music", music_volume)
	EventSystem.set_volume.emit("Sfx", sfx_volume)

func set_volumes_value(channel, value) -> void :
	print("set_volume_value - channel:", channel, ",value:", value)
	var bus_id = AudioServer.get_bus_index(channel)
	if bus_id != null:
		AudioServer.set_bus_volume_db(bus_id, value)
	
#TODO Add teh folder to the key name, so we can have files with the same name in different folders
func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				dir_contents(dir.get_current_dir() + "/" + file_name)
			else:
				print("Found file: " + file_name)
				file_name = file_name.replace(".import", "")
				var key = file_name.replace("." + file_name.get_extension(), "")
				if not audio_files.has(key):
					var absolute_file_path = dir.get_current_dir() + "/" + file_name
					#var audio_file : AudioStream  = AudioStream.load()
					audio_files[key] = ResourceLoader.load(absolute_file_path, "AudioStream")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func music_player_ended() -> void:
	pass

func _on_stream_finished():
	# When finished playing a stream, make the player available again.
#	available.append()
	pass

func play_audio_event(audio_key, bus) -> void:
	print("Play audio event audio:", audio_key)
	print("Play audio event bus:", bus)
	if audio_files.has(audio_key):
		play(audio_files[audio_key])

func play_music_event(audio_key) -> void:
	print("Play music event audio:", audio_key)
	if audio_files.has(audio_key):
		music_player.stream = audio_files[audio_key]
		if music_player.playing:
			music_player.stop()
		music_player.play()

func stop_audio_event(audio_key) -> void:
	if audio_files.has(audio_key):
		var stream : AudioStream = audio_files[audio_key]
		for player in available:
			if player.stream == stream:
				player.stop()
				break

func stop_music_event(audio_key) -> void:
	if audio_files.has(audio_key):
		music_player.stream = audio_files[audio_key]
		if music_player.playing:
			music_player.stop()

func play(sound : AudioStream):
	if sound != null:
		queue.append(sound)

func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty():
		var notPlaying = available.filter(isStreamStopped)
		if not notPlaying.is_empty():
			var player = notPlaying.pop_front()
			player.stream = queue.pop_front()
			if mute:
				player.volume_db = -80
			else:
				player.volume_db = 0
			player.play()

func isStreamStopped(player):
	return not player.playing
