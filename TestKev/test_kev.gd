extends Node2D

@export var thoot_item : ItemData
@export var magic_book_item : ItemData
@export var chalice_item : ItemData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_kev1"):
		TriggersSystem.toggle_trigger("second_boss_call")
	
	if Input.is_action_just_pressed("debug_kev2"):
		InventorySystem.drop_item(thoot_item)
		InventorySystem.drop_item(magic_book_item)
		InventorySystem.drop_item(chalice_item)
