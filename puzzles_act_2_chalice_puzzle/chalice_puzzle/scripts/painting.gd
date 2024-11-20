extends Node2D
@export var statues : Array[Node2D]
@export var task_chalice : Task
@export var dialog : Array[DialogText]
@export var open_dialog : Array[DialogText]
@export var item_data : ItemData
@export var combination = ["Left", "Front", "Right"]
@onready var painting_opened = $PaintingOpened
@onready var painting_closed = $PaintingClosed
@onready var interactable = $Interactable
@onready var label_pick = $Label

var done = false

func _ready() -> void:
	interactable.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TriggersSystem.check_trigger("opened_painting", true):
		painting_closed.hide()
		painting_opened.show()
		interactable.show()
	else:
		opened_painting()

func opened_painting():
	var open = true
	
	for i in range(0,4):
		var check = statues[i].direction_statue == combination[i]
		open = check and open
		print("position_statue", statues[i].direction_statue)
		print("combination", combination[i])
		
	if open:
		TriggersSystem.update_trigger("opened_painting", true)
		DialogueSystem.start_dialog(open_dialog)

func _on_interactable_player_enter() -> void:
	if not done and TriggersSystem.check_trigger("opened_painting", true): 
		label_pick.show()


func _on_interactable_player_exit() -> void:
	label_pick.hide()


func _on_interactable_interacted() -> void:
	if not done and TriggersSystem.check_trigger("opened_painting", true):
		InventorySystem.pick_up(item_data)
		EventSystem.task_completed.emit(task_chalice.id)
		DialogueSystem.start_dialog(dialog)
		interactable.hide()
		done = true
	
