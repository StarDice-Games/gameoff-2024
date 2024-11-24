extends Node2D

enum PLAYER_DIR {
	UP, 
	UP_RIGHT,
	RIGHT,
	DOWN_RIGHT,
	DOWN,
	DOWN_LEFT,
	UP_LEFT,	
	LEFT
}

#last link that the player passed
var last_player_link_id : String
var last_player_dir : PLAYER_DIR

@onready var timer = $Timer

@export var audio_id : String = "Phone_Ring"
var playing  = false

func _ready() -> void:
	EventSystem.ring_phone.connect(ring_global_phone)
	EventSystem.stop_ring_phone.connect(stop_ring_phone)
	
	EventSystem.trigger_changed.connect(trigger_update)
	#if TriggersSystem.check_trigger("ring", true):
		#EventSystem.ring_phone.emit("Phone_Ring")

func trigger_update(key, value):
	if key == "ring":
		if value == true:
			ring_global_phone(audio_id)
		if value == false:
			stop_ring_phone()
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("debug_tel"):
		#EventSystem.ring_phone.emit("Phone_Ring")
	#if Input.is_action_just_pressed("stop_tel_debug"):
		#EventSystem.stop_ring_phone.emit("Phone_Ring")

func ring_global_phone(audio_id : String):
	if not playing :
		timer.start()
		#self.audio_id = audio_id
		AudioSystem.play_audio_event(self.audio_id, "Sfx")
		playing = true

func stop_ring_phone():
	timer.stop()
	AudioSystem.stop_audio_event(self.audio_id)
	playing = false

func _on_timer_timeout() -> void:
	AudioSystem.play_audio_event(audio_id, "Sfx")
