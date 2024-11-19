extends Node2D

@onready var corridoio: Portal = $Corridoio

func _ready() -> void:
	TriggersSystem.update_trigger("doors_locked", true)
	corridoio.level_id = "corridoio"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TriggersSystem.check_trigger("boss_exit", true):
		TriggersSystem.update_trigger("doors_locked", false)
		corridoio.level_id = "corridoio"
	
	
