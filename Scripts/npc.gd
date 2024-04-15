class_name NPC
extends Node2D

@export var dialogs:Array
@export var player:CharacterBody2D = null
var next_state = null

var dialogIndex = -1;
var firstGift = true

var kiss = 0
var marry = 0
var kill = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	next_state = null
	if not player:
		print("No Player ? :(")
	if name == 'Cave Of Lost Souls':
		var sprite = get_node("Sprite2D")
		sprite.set_visible(false)
	
func talk():
	if(name == 'Cave Of Lost Souls'):
		start_cave_dialog()
	else:
		transition()
		print("Talking... : ", dialogIndex)
		if dialogIndex >= 0:
			next_state = dialogs[dialogIndex]
			start_dial(next_state)

func start_dial(dial):
	player.block_movements()
	
	player.set_kill_stat(kill)
	player.set_marry_stat(marry)
	player.set_kiss_stat(kiss)
	
	player.current_npc = self
	
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start(dial)
	
func gift():
	next_state = "Gift1"
	if firstGift:
		firstGift = false
		start_dial("Gift1")
	else:
		start_dial("Gifts")
func ended():
	player.enable_movements()
	Dialogic.timeline_ended.disconnect(ended)

func transition(): #This will be overriden
	dialogIndex = (dialogIndex + 1) % dialogs.size()

func on_kiss():
	print("got kissed")
	pass
func on_marry():
	print("got maried")
	pass
func on_kill():
	print("got killed")
	pass


func start_cave_dialog():
	player.block_movements()
	player.pause_pentagrams()
	player.isInCorvee = true
	player.kmkUi.hide()
	player.hide_stats_ui()
	player.timeUi.show()
	
	player.current_npc = self
	
	Dialogic.timeline_ended.connect(caveEnded)
	Dialogic.signal_event.connect(caveEvent)
	Dialogic.start("caveDialog")

func caveEnded():
	player.timeUi.hide()
	Dialogic.signal_event.disconnect(caveEvent)
	Dialogic.timeline_ended.disconnect(caveEnded)
	Dialogic.VAR.set("Souls", player.getSoulNumber())
	player.enable_movements()
	player.unpause_pentagrams()
	player.canTalkAfterTimer.start()

func caveEvent(event):
	if(event == "resetAzazael"):
		player.removeSouls(10)
		print("resetAzazael")
	if(event == "resetGos"):
		player.removeSouls(10)
		print("resetGos")
	if(event == "resetDolore"):
		player.removeSouls(10)
		print("resetDolore")
	if(event == 'nothing'):
		print("nothing")


