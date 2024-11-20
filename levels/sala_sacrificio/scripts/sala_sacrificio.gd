extends Node2D

func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	TriggersSystem.update_trigger("doors_locked", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_kev1"):
		TriggersSystem.update_trigger("ritual_object_placed", true)

func trigger_update(key, value):	
	if key == "boss_exit" and value == true:
		$AnimationPlayer.play("boss_walk")
		TriggersSystem.update_trigger("doors_locked", false)
	
	
	
