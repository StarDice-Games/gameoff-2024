extends Node2D
@export var item_data : ItemData
var drop_item = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StarDiceSprite.texture = item_data.icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drop_item and Input.is_action_just_pressed("interact"):
		if InventorySystem.check_item(item_data):
			InventorySystem.drop_item(item_data)
			$StarDiceSprite.show()
			$StaticBody2D/Area2D.hide()
		else:
			$Label2.show()

func _on_area_2d_mouse_entered() -> void:
	drop_item = true
	$Label3.show()


func _on_area_2d_mouse_exited() -> void:
	drop_item = false
	$Label2.hide()
	$Label3.hide()
