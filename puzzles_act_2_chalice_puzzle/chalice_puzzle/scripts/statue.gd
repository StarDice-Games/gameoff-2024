extends Node2D

@export var audio_sfx = AudioStream

@onready var text_prompt = $Label
@onready var interactable_statue = $Interactable
@onready var sprite_front = $"StaticBody2D/statue front"
@onready var sprite_back = $"StaticBody2D/statue back"
@onready var sprite_left = $"StaticBody2D/statue left"
@onready var sprite_right = $"StaticBody2D/statue right"
var direction_statue : String


var position_statue = ["Front", "Back", "Left", "Right"]
var counter_position = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	sprite_front.show()
	sprite_back.hide()
	sprite_left.hide()
	sprite_right.hide()
	direction_statue = position_statue[counter_position]
	
	if TriggersSystem.check_trigger("opened_painting", true):
			$Interactable.queue_free()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func trigger_update(key, value):	
	if key == "opened_painting" and value == true:
		interactable_statue.queue_free()
		text_prompt.hide()

func _on_interactable_player_enter() -> void:
	text_prompt.show()


func _on_interactable_player_exit() -> void:
	text_prompt.hide()


func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("opened_painting", true):
		interactable_statue.hide()
	counter_position += 1
	if counter_position >= position_statue.size():
		counter_position = 0
	match position_statue[counter_position]: 
		"Front":
			AudioSystem.play_audio_event("Drag_Statue_01", "Sfx")
			direction_statue = "Front"
			sprite_front.show()
			sprite_back.hide()
			sprite_left.hide()
			sprite_right.hide()
			$HighlightComponent.sprite = $"StaticBody2D/statue front"
			$HighlightComponent.sprite.material = $HighlightComponent.shader
			$PreArea.sprite = $"StaticBody2D/statue front"
			$PreArea.sprite.material = $PreArea.shader
			$"StaticBody2D/statue back".material = null
			$"StaticBody2D/statue left".material = null
			$"StaticBody2D/statue right".material = null
		"Back":
			AudioSystem.play_audio_event("Drag_Statue_01", "Sfx")
			direction_statue = "Back"
			sprite_front.hide()
			sprite_back.show()
			sprite_left.hide()
			sprite_right.hide()
			$HighlightComponent.sprite = $"StaticBody2D/statue back"
			$HighlightComponent.sprite.material = $HighlightComponent.shader
			$PreArea.sprite = $"StaticBody2D/statue back"
			$PreArea.sprite.material = $PreArea.shader
			$"StaticBody2D/statue front".material = null
			$"StaticBody2D/statue left".material = null
			$"StaticBody2D/statue right".material = null
		"Left":
			AudioSystem.play_audio_event("Drag_Statue_01", "Sfx")
			direction_statue = "Left"
			sprite_front.hide()
			sprite_back.hide()
			sprite_left.show()
			sprite_right.hide()
			$HighlightComponent.sprite = $"StaticBody2D/statue left"
			$HighlightComponent.sprite.material = $HighlightComponent.shader
			$PreArea.sprite = $"StaticBody2D/statue left"
			$PreArea.sprite.material = $PreArea.shader
			$"StaticBody2D/statue front".material = null
			$"StaticBody2D/statue back".material = null
			$"StaticBody2D/statue right".material = null
		"Right":
			direction_statue = "Right"
			AudioSystem.play_audio_event("Drag_Statue_01", "Sfx")
			sprite_front.hide()
			sprite_back.hide()
			sprite_left.hide()
			sprite_right.show()
			$HighlightComponent.sprite = $"StaticBody2D/statue right"
			$HighlightComponent.sprite.material = $HighlightComponent.shader
			$PreArea.sprite = $"StaticBody2D/statue right"
			$PreArea.sprite.material = $PreArea.shader
			$"StaticBody2D/statue front".material = null
			$"StaticBody2D/statue left".material = null
			$"StaticBody2D/statue back".material = null
		_:
			printerr("Unexpected position value:", position_statue[counter_position])
