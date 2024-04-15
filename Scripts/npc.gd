class_name NPC
extends Node2D

@export var dialogs:Array
@export var player:CharacterBody2D = null
var next_state = null

var dialogIndex = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	next_state = dialogs[0]
	if not player:
		print("No Player ? :(")
	
	
func talk():
	Dialogic.timeline_ended.connect(ended)
	player.block_movements()
	Dialogic.start(dialogs[dialogIndex])

func ended():
	player.enable_movements()
	transition()
	Dialogic.timeline_ended.disconnect(ended)

func transition(): #This will be overriden
	dialogIndex = (dialogIndex + 1) % dialogs.size()
	next_state = dialogs[dialogIndex]
