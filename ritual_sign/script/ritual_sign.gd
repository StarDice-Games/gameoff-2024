extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	if TriggersSystem.check_trigger("ritual_objects_placed", true):
		sprite_2d.modulate = "#c10022"

func trigger_update(key, value):	
	if key == "ritual_objects_placed" and value == true:
		$AnimationPlayer.play("change_color")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
