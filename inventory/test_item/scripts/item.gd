extends Node2D

@export var item_data : ItemData
var pick_up = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and pick_up:
			InventorySystem.pick_up(item_data)
			pick_up = false
			hide()


func _on_interaction_area_2d_mouse_entered() -> void:
	pick_up = true
	$Label.show()

func _on_interaction_area_2d_mouse_exited() -> void:
	pick_up = false
	$Label.hide()
	
