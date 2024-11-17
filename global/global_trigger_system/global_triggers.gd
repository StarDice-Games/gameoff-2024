extends Node

@export var keys : Array[String]
var triggers : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for trigger in keys :
		triggers[trigger] = false

func update_trigger(key : String, value: bool):
	if not triggers.has(key):
		printerr("Trigger ", key, " not present!")
		return
	triggers[key] = value
	EventSystem.trigger_changed.emit(key, value)

func toggle_trigger(key : String):
	if not triggers.has(key):
		printerr("Trigger ", key, " not present!")
		return
	triggers[key] = not triggers[key]
	EventSystem.trigger_changed.emit(key, triggers[key])

func check_trigger(key: String, value: bool) -> bool:
	if not triggers.has(key):
		printerr("Trigger ", key, " not present!")
		return false	
	return triggers[key] == value

func all(checks : Array[String]) -> bool :
	if not triggers.has_all(checks) :
		return false;
	
	for t in checks :
		if triggers[t] == false:
			return false;
	
	return true;

func all_req(checks : Array[Requirement]) -> bool :
	for t in checks :
		if !triggers.has(t.key) or triggers[t.key] != t.value:
			return false;
	
	return true;

func any_req(checks : Array[Requirement]) -> bool :
	for t in checks :
		if triggers.has(t.key) or triggers[t.key] == t.value:
			return true;
	
	return false;

func one(checks : Array[String]) -> bool :
	for t in checks :
		if triggers.has(t) and triggers[t] == true:
			return true;
	return false;
