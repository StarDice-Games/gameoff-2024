class_name UIStateMachine
extends Node

@export var states : Array[UIState]
@onready var current_state: UIState = states[0]


func _ready() -> void:
	
	for state in states:
		state.init(self)
	
	current_state.enter()
	
	EventSystem.cutscene_started.emit()
	#EventSystem.connect("change_ui_state", change_state)


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func change_state(target_state_name: String, msg: Dictionary = {}) -> void:
	
	if not states.any(func(state): return state.name == target_state_name):
		return

	current_state.exit()
	current_state = get_node(target_state_name)
	current_state.enter(msg)
