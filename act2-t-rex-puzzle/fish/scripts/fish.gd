extends StaticBody2D

@export var trigger : String =  "rope_taken"
@export var interact_text : String = "Interact"

@onready var interact_label = $Label

var taken = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	taken = TriggersSystem.check_trigger(trigger, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interactable_interacted() -> void:
	TriggersSystem.update_trigger(trigger, true)
	taken = true
	$Rope.show()
	$AnimationPlayer.play("fall")
	$Interactable.queue_free()
	$CollisionShape2D.queue_free()

func _on_interactable_player_enter() -> void:
	if taken :
		return
	
	interact_label.text = interact_text
	interact_label.show()

func _on_interactable_player_exit() -> void:
	interact_label.hide()
