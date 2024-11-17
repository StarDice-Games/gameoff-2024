extends Node2D

enum Action {
	HIDE,
	SHOW
}

@export var action : Action
@export var trigger : Requirement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventSystem.trigger_changed.connect(change_toggle)
	#if TriggersSystem.check_trigger(trigger.key, trigger.value) :
		#toggle_node()

func _process(delta: float) -> void:
	if TriggersSystem.check_trigger(trigger.key, trigger.value):
		#do the selected action
		toggle_node()
	else:
		#do the opposite
		toggle_node(true)

func toggle_node(reverse : bool = false):
	var parent : Node2D = get_parent() 
	if parent == null :
		printerr(name, "Trigger Changed, Missing parent")
		return
	
	if not reverse:
		match action:
			Action.HIDE:
				parent.hide()
				parent.process_mode = Node.PROCESS_MODE_DISABLED
			Action.SHOW:
				parent.show()
				parent.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if reverse: 
		match action:
			Action.HIDE:
				parent.show()
				parent.process_mode = Node.PROCESS_MODE_ALWAYS	
			Action.SHOW:
				parent.hide()
				parent.process_mode = Node.PROCESS_MODE_DISABLED
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func change_toggle(key : String, value : bool) -> void:
	#if key == trigger.key and value == trigger.value:
		#toggle_node()

#this is needed for when the node is disabled ? cause it does not go in process
func change_toggle(key : String, value : bool):
	if TriggersSystem.check_trigger(trigger.key, trigger.value):
		#do the selected action
		toggle_node()
	else:
		#do the opposite
		toggle_node(true)
