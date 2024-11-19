extends Node2D

@export var item : ItemData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	InventorySystem.pick_up(item)
	hide()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	
