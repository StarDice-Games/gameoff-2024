extends Node2D

var items_array : Array[ItemData] = []
@onready var inventory = $CanvasLayer/Control
@onready var inventory_slot = $CanvasLayer/Control/Panel/HBoxContainer

var index = 0
func _ready() -> void:
	#hide_inventory()
	EventSystem.hide_hud.connect(hide_inventory)
	EventSystem.show_hud.connect(show_inventory)
	EventSystem.cutscene_started.connect(hide_inventory)
	EventSystem.cutscene_finished.connect(show_inventory)
	
	
func pick_up(data: ItemData):
	items_array.append(data)
	var slot = TextureRect.new()
	slot.texture = data.icon
	#size is a placeholder
	slot.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	inventory_slot.add_child(slot)
	EventSystem.picked_up_item.emit(data.id)
	
#TODO use a for i in range , on the item_array so we can remove the find and move the remove_at out of the loop
func drop_item(data: ItemData):
	for i in items_array:
		if i.id == data.id:
			var item_index = items_array.find(i)
			items_array.remove_at(item_index)
			break
	
	update_ui()
	
	EventSystem.dropped_item.emit(data.id)

func check_item(data: ItemData):
	var res = false
	for item in items_array:
		if item.id == data.id:
			res = true
			break
	return res

func update_ui():
	inventory_slot.get_children().clear()
	
	if inventory_slot.get_child_count() > 0 :
		for child in inventory_slot.get_children():
			inventory_slot.remove_child(child)
			child.queue_free()
	
	for item in items_array:
		var slot = TextureRect.new()
		slot.texture = item.icon
		#size is a placeholder
		slot.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		inventory_slot.add_child(slot)

func hide_inventory():
	inventory.hide()

func show_inventory():
	inventory.show()
