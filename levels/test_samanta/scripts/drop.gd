extends StaticBody2D

@export var item_sword : ItemData

var has_item = false
var drop_item = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	has_item = InventorySystem.check_item(item_sword)
	EventSystem.picked_up_item.connect(picked_up)
	
	if drop_item:
		hide()
	else:
		show()
		
func picked_up(item_id : String):
	if item_id == item_sword.id:
		has_item = true

func _on_interactable_interacted() -> void:
	if not InventorySystem.check_item(item_sword):
		print("not item", has_item)
		$Label2.show()
		$Label2.text = "not item"
		return
	else: 
		InventorySystem.drop_item(item_sword)
		$"../Label".text = "dropped item"
		$Label.hide()
		$Interactable.queue_free()
		drop_item = true


func _on_interactable_player_exit() -> void:
	$Label2.hide()
	$Label.hide()


func _on_interactable_player_enter() -> void:
	$Label.show()
