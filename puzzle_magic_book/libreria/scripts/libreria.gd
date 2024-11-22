extends StaticBody2D

@export var open_trigger : String =  "libreria_open"
@export var key_item : ItemData
@export var need_code_dialog : Array[DialogText]
@export var interact_text : String = "Interact"

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
	
	open_sprite.hide()
	close_sprite.hide()
	interact_label.hide()
	
	if open:
		open_sprite.show()
		$MagicBook.show()
		$Interactable.queue_free()
	else :
		close_sprite.show()
		
	if TriggersSystem.check_trigger("got_magic_book", true):
		$MagicBook.hide()
	
	EventSystem.picked_up_item.connect(postit_picked)

func postit_picked(item_id : String):
	if item_id == key_item.id:
		has_key = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if open :
		return
	
	if not open:
		if not has_key :
			DialogueSystem.start_dialog(need_code_dialog)
		else :
			open_sprite.show()
			close_sprite.hide()
			TriggersSystem.update_trigger(open_trigger, true)
			open = true
			$MagicBook.show()
			$Interactable.queue_free()
			interact_label.hide()
			InventorySystem.drop_item(key_item)

func _on_interactable_player_enter() -> void:
	if open :
		return
	
	interact_label.text = interact_text
	interact_label.show()

func _on_interactable_player_exit() -> void:
	interact_label.hide()
