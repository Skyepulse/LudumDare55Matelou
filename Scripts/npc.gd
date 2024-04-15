class_name NPC
extends Node2D

@export var dialogs:Array
@export var player:CharacterBody2D = null
var next_state = null

var dialogIndex = 0;
var firstDialog = true
var firstGift = true

var kiss = 0
var marry = 0
var kill = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	next_state = dialogs[0]
	if not player:
		print("No Player ? :(")
	
	
func talk():
	Dialogic.timeline_ended.connect(ended)
	player.block_movements()
	if not firstDialog:
		transition()
	firstDialog = false
	next_state = dialogs[dialogIndex]
	Dialogic.start(dialogs[dialogIndex])

func gift():
	if firstGift:
		firstGift = false
		Dialogic.start("Gift1")
	else:
		Dialogic.start("Gift2")
func ended():
	player.enable_movements()
	Dialogic.timeline_ended.disconnect(ended)

func transition(): #This will be overriden
	dialogIndex = (dialogIndex + 1) % dialogs.size()
