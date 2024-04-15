class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state := NodePath()

@export var conditions:Dictionary

@onready var state: State = get_node(initial_state)



func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.state_machine = self
	state.enter()


func transition_to(target_state_name: String) -> void:
	if not has_node(target_state_name):
		return

	state = get_node(target_state_name)
	emit_signal("transitioned", state.name)
