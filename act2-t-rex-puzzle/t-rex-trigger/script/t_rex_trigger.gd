extends Node2D
@onready var label_text = $StaticBody2D/Label
@onready var t_rex_tooth = $StaticBody2D/Dente
@onready var t_rex_tooth_rope = $StaticBody2D/TrexToothRope

@export var dialog : Array[DialogText]
@export var item : ItemData
@export var audio_sfx = AudioStream

var can_pull = false
var has_rope = false

func _ready() -> void:
	has_rope = InventorySystem.check_item(item)
	EventSystem.picked_up_item.connect(picked_rope)
	EventSystem.dropped_item.connect(dropped_rope)
	
	if TriggersSystem.check_trigger("can_pool", true):
		t_rex_tooth.hide()
		$HighlightComponent.sprite = $StaticBody2D/TrexToothRope
		t_rex_tooth_rope.show()
		label_text.text = "Pull"
		
	if TriggersSystem.check_trigger("pulled_out", true):
		$Interactable.queue_free()
		t_rex_tooth_rope.hide()
		if TriggersSystem.check_trigger("tooth_picked", false):
			$StaticBody2D/TRexTooth.show()

func picked_rope(item_id : String):
	if item_id == item.id:
		has_rope = true
		print(item_id)
		
func dropped_rope(item_id : String):
	if item_id == item.id:
		has_rope = false

func _on_interactable_player_enter() -> void:
	label_text.show()

func _on_interactable_player_exit() -> void:
	label_text.hide()

func _on_interactable_interacted() -> void:
	if TriggersSystem.check_trigger("rope_picked", true):
		if not can_pull and has_rope:
			t_rex_tooth.hide()
			t_rex_tooth_rope.show()
			AudioSystem.play(audio_sfx)
			label_text.text = "Pull"
			$HighlightComponent.sprite = $StaticBody2D/TrexToothRope
			$HighlightComponent.sprite_changed.emit()
			$HighlightComponent/CollisionShape2D.disabled = true
			TriggersSystem.toggle_trigger("can_pool")
			can_pull = true
			InventorySystem.drop_item(item)
		else:
			can_pull = false
			t_rex_tooth_rope.hide()
			TriggersSystem.toggle_trigger("pulled_out")
			$Interactable.queue_free()
			label_text.hide()
			$StaticBody2D/TRexTooth.show()
	else:
		DialogueSystem.start_dialog(dialog)
		
