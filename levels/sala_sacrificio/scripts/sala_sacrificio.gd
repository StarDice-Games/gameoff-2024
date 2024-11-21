extends Node2D

func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	TriggersSystem.update_trigger("doors_locked", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger_update(key, value):	
	if key == "boss_exit" and value == true:
		$AnimationPlayer.play("boss_walk")
		TriggersSystem.update_trigger("doors_locked", false)
	
	
	
