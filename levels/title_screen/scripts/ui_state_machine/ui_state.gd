class_name UIState
extends Control

var state_machine = null

func init(_state_machine: UIStateMachine) -> void:
	state_machine = _state_machine

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass


func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
