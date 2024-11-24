extends Node2D

var items_array : Array[ItemData] = []
@onready var inventory = $CanvasLayer/Control
@onready var inventory_slot = $CanvasLayer/Control/Panel/HBoxContainer
@export var audio_sfx = AudioStream

func _ready() -> void:
	
	EventSystem.hide_hud.connect(hide_inventory)
	EventSystem.show_hud.connect(show_inventory)
	EventSystem.cutscene_started.connect(hide_inventory)
	EventSystem.cutscene_finished.connect(show_inventory)
	
	
func pick_up(data: ItemData):
	items_array.append(data)
	var slot = TextureRect.new()
	slot.texture = data.icon
	slot.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	slot.stretch_mode = TextureRect.STRETCH_SCALE
	#size is a placeholder
	slot.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	inventory_slot.add_child(slot)
	AudioSystem.play(audio_sfx)
	EventSystem.picked_up_item.emit(data.id)
	

func drop_item(data: ItemData):
	var item_index
	for i in range(items_array.size()):
		if items_array[i].id == data.id:
			item_index = i
			break
	items_array.remove_at(item_index)
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
