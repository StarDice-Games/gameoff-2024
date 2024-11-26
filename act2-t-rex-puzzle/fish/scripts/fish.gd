extends StaticBody2D

@export var trigger : String =  "rope_taken"
@export var interact_text : String = "Interact"

@onready var interact_label = $Label

var taken = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	taken = TriggersSystem.check_trigger(trigger, true)
	
	if TriggersSystem.check_trigger(trigger, true):
		taken = true
		$Interactable.queue_free()
		$HighlightComponent.queue_free()
		$PreArea.queue_free()
		interact_label.hide()
		$Corda.hide()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interactable_interacted() -> void:
	TriggersSystem.update_trigger(trigger, true)
	taken = true
	$Interactable.queue_free()
	$HighlightComponent.queue_free()
	$HighlightComponent.queue_free()
	$PreArea.queue_free()
	interact_label.hide()
	$Corda.hide()
	
func _on_interactable_player_enter() -> void:
	if taken :
		return
	
	interact_label.text = interact_text
	interact_label.show()

func _on_interactable_player_exit() -> void:
	interact_label.hide()
