extends Node2D
@onready var text_prompt = $Label
@onready var sprite_front = $"StaticBody2D/statue front"
@onready var sprite_back = $"StaticBody2D/statue back"
@onready var sprite_left = $"StaticBody2D/statue left"
@onready var sprite_right = $"StaticBody2D/statue right"
@export var direction_statue : String

var position_statue = ["Front", "Back", "Left", "Right"]
var counter_position = 0
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass



func _on_interactable_player_enter() -> void:
	text_prompt.show()


func _on_interactable_player_exit() -> void:
	text_prompt.hide()


func _on_interactable_interacted() -> void:
	counter_position += 1
	if counter_position >= position_statue.size():
		counter_position = 0
	match position_statue[counter_position]: 
		"Front":
			direction_statue = "Front"
			sprite_front.show()
			sprite_back.hide()
			sprite_left.hide()
			sprite_right.hide()
		"Back":
			direction_statue = "Back"
			sprite_front.hide()
			sprite_back.show()
			sprite_left.hide()
			sprite_right.hide()
		"Left":
			direction_statue = "Left"
			sprite_front.hide()
			sprite_back.hide()
			sprite_left.show()
			sprite_right.hide()
		"Right":
			direction_statue = "Right"
			sprite_front.hide()
			sprite_back.hide()
			sprite_left.hide()
			sprite_right.show()
		_:
			printerr("Unexpected position value:", position_statue[counter_position])
