extends StaticBody2D

@export var open_trigger : String =  "guardian_locker_open"
@export var post_it_item : ItemData
@export var key_item : ItemData
@export var need_code_dialog : Array[DialogText]
@export var key_collected : Array[DialogText]
@export var interact_text : String = "Interact"
@export var interact_pickup_text : String = "Pick up"

@onready var interact_label = $Label
@onready var open_sprite = $LockerOpen
@onready var close_sprite = $LockerClosed

var open = false
var has_post_it = false
var picked_up_key = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = TriggersSystem.check_trigger(open_trigger, true)
	has_post_it = InventorySystem.check_item(post_it_item)
	picked_up_key = InventorySystem.check_item(key_item)
	
	open_sprite.hide()
	close_sprite.hide()
	interact_label.hide()
	
	if open:
		open_sprite.show()
	else :
		close_sprite.show()
	
	EventSystem.picked_up_item.connect(postit_picked)

func postit_picked(item_id : String):
	if item_id == post_it_item.id:
		has_post_it = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if picked_up_key :
		return
	
	if not open:
		if not has_post_it :
			DialogueSystem.start_dialog(need_code_dialog)
		else :
			open_sprite.show()
			close_sprite.hide()
			InventorySystem.drop_item(post_it_item)
			TriggersSystem.update_trigger(open_trigger, true)
			interact_label.text = interact_pickup_text #update the label
			open = true
	else :
		InventorySystem.pick_up(key_item)
		DialogueSystem.start_dialog(key_collected)
		picked_up_key = true


func _on_interactable_player_enter() -> void:
	if picked_up_key :
		return
	
	if not open:
		interact_label.text = interact_text
	else:
		interact_label.text = interact_pickup_text
	interact_label.show()

func _on_interactable_player_exit() -> void:
	interact_label.hide()
