extends StaticBody2D

@export var open_trigger : String =  "libreria_open"
@export var final_trigger : String =  "got_magic_book"
@export var magic_book_item : ItemData
@export var key_item : ItemData
@export var need_code_dialog : Array[DialogText]
@export var player_monolog : Array[DialogText]
@export var interact_text : String = "Interact"
@export var interact_pickup_text : String = "Pick up"
@export var task_book : Task

@onready var interact_label = $Label
@onready var open_sprite = $Open
@onready var close_sprite = $Closed

var open = false
var has_key = false
var picked_up_book = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = TriggersSystem.check_trigger(open_trigger, true)
	has_key = InventorySystem.check_item(key_item)
	picked_up_book = InventorySystem.check_item(magic_book_item) || TriggersSystem.check_trigger(final_trigger, true)
	
	open_sprite.hide()
	close_sprite.hide()
	interact_label.hide()
	
	if open:
		open_sprite.show()
	else :
		close_sprite.show()
	
	EventSystem.picked_up_item.connect(postit_picked)

func postit_picked(item_id : String):
	if item_id == key_item.id:
		has_key = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if picked_up_book :
		return
	
	if not open:
		if not has_key :
			DialogueSystem.start_dialog(need_code_dialog)
		else :
			open_sprite.show()
			close_sprite.hide()
			InventorySystem.drop_item(key_item)
			TriggersSystem.update_trigger(open_trigger, true)
			interact_label.text = interact_pickup_text #update the label
			open = true
	else :
		InventorySystem.pick_up(magic_book_item)
		picked_up_book = true
		EventSystem.task_completed.emit(task_book.id)
		TriggersSystem.update_trigger(final_trigger, true)
		DialogueSystem.start_dialog(player_monolog)

func _on_interactable_player_enter() -> void:
	if picked_up_book :
		return
	
	if not open:
		interact_label.text = interact_text
	else:
		interact_label.text = interact_pickup_text
	interact_label.show()

func _on_interactable_player_exit() -> void:
	interact_label.hide()
