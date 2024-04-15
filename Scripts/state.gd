class_name State
extends Node

@export var dialog:DialogicTimeline

@export var next_dialogs:Array[State]

@export var next_dialogs_conditions:Array[Array]

var state_machine = null

func transition() -> void:
	pass
