extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	if TriggersSystem.check_trigger("ritual_sign", true):
		sprite_2d.modulate = "#c10022"

func trigger_update(key, value):	
	if key == "ritual_sign" and value == true:
		$Timer.start()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TriggersSystem.toggle_trigger("stealth")
	EventSystem.cutscene_started.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	EventSystem.cutscene_started.emit()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("change_color")
