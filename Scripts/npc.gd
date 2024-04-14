extends Node2D

@export var dialogs:Array[DialogicTimeline]
@export var player:CharacterBody2D = null
var dialogIndex = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	if not player:
		print("No Player ? :(")
	
	
func talk():
	Dialogic.timeline_ended.connect(ended)
	player.block_movements()
	Dialogic.start(dialogs[dialogIndex])

func ended():
	player.enable_movements()
	Dialogic.timeline_ended.disconnect(ended)
	dialogIndex = (dialogIndex + 1) % dialogs.size()

