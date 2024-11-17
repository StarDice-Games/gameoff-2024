extends StaticBody2D

@export var open_trigger : String =  "guardian_locker_open"
@export var post_it_item : ItemData

@onready var interact_label = $Label
@onready var open_sprite = $LockerOpen
@onready var close_sprite = $LockerClosed

var open = false
var has_post_it = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = TriggersSystem.check_trigger(open_trigger, true)
	has_post_it = InventorySystem.check_item(post_it_item)
	
	open_sprite.hide()
	close_sprite.hide()
	interact_label.hide()
	
	if open:
		open_sprite.show()
	else :
		close_sprite.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	pass # Replace with function body.


func _on_interactable_player_enter() -> void:
	interact_label.show()


func _on_interactable_player_exit() -> void:
	interact_label.hide()
