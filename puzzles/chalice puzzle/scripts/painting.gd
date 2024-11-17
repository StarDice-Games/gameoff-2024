extends Node2D
@export var statues : Array[Node2D]
var combination = ["Left", "Front", "Right"]
@onready var painting_opened = $PaintingOpened
@onready var painting_closed = $PaintingClosed

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	opened_painting()
	if TriggersSystem.check_trigger("opened_painting", true):
		painting_closed.show()
		painting_opened.hide()

func opened_painting():
	var open
	for i in range(0,3):
		open = statues[i].direction_statue == combination[i]
		print("position_statue", statues[i].direction_statue)
		print("combination", combination[i])
	if open:
		TriggersSystem.update_trigger("opened_painting", true)
