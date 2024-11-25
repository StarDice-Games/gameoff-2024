extends Node2D

@onready var label: Label = $Label
@onready var sprite_object: Sprite2D = $Sprite_object
@onready var sprite_empty: Sprite2D = $Sprite_empty
@onready var interactable: Interactable = $Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(trigger_update)
	
	$HighlightComponent2/CollisionShape2D.disabled = true
	$HighlightComponent3/CollisionShape2D.disabled = true
	
	if TriggersSystem.check_trigger("ritual_objects_placed", true):
		sprite_object.show()
		interactable.queue_free()
		$HighlightComponent2.queue_free()
		$HighlightComponent3.queue_free()

func trigger_update(key, value):	
	if key == "talk_boss" and value == true:
		$HighlightComponent2/CollisionShape2D.disabled = false
		$HighlightComponent3/CollisionShape2D.disabled = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("talk_boss", true):
		sprite_object.show()
		TriggersSystem.toggle_trigger("ritual_objects_placed")
		$AnimationPlayer.play("thunder")
		interactable.queue_free()
		$HighlightComponent2.queue_free()
		$HighlightComponent3.queue_free()
		label.hide()

func _on_interactable_player_enter() -> void:
	if TriggersSystem.check_trigger("talk_boss", true):
		label.show()


func _on_interactable_player_exit() -> void:
	label.hide()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	AudioSystem.set_volumes_value("Music", AudioSystem.music_volume - 80)
	EventSystem.cutscene_started.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AudioSystem.play_music_event("go2024_phase3_v1")
	AudioSystem.set_volumes_value("Music", 0)
	EventSystem.cutscene_finished.emit()
