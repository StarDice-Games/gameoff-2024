extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	EventSystem.set_volume.emit("Music", -80)
	InventorySystem.hide_inventory()
	TaskSystem.hide_task_list()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout() -> void:
	TriggersSystem.update_trigger("close_museum", false)
	TriggersSystem.update_trigger("act_3", true)
	LevelSystem.load_level("guardiola", true)
