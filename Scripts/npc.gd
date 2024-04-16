class_name NPC
extends Node2D

@export var dialogs:Array
@export var player:CharacterBody2D = null
var next_state = null

var dialogIndex = -1;
var firstGift = true
@onready var beatingHeartItemType:Resource = preload("res://items/heart.tres")
@onready var holyWater:Resource = preload("res://items/water.tres")
@onready var blueTeddyBear:Resource = preload("res://items/tedyy.tres")
@onready var pigeonBloodRuby:Resource = preload("res://items/bloodRuby.tres")
@onready var preservedHaggish:Resource = preload("res://items/haggish.tres")
var kiss = 0
var marry = 0
var kill = 0

#signals to reset the relationships
signal sig_azazael
signal sig_gos 
signal sig_dolore

enum Liking {LOVE, NEUTRAL, HATE, NONE}

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
	player.pause_pentagrams()
	player.set_kill_stat(kill)
	player.set_marry_stat(marry)
	player.set_kiss_stat(kiss)
	player.isInCorvee = true
	player.current_npc = self
	
	Dialogic.timeline_ended.connect(ended)
	Dialogic.signal_event.connect(get_signal_event)
	Dialogic.start(dial)

func get_signal_event(arg: Dictionary):
	if arg.has("kiss"):
		kiss += int(arg.get("kiss"))
		print("kiss += ", arg.get("kiss"))
	if arg.has("marry"):
		marry += int(arg.get("marry"))
		print("marry += ", arg.get("marry"))
	if arg.has("kill"):
		kill += int(arg.get("kill"))
		print("kill += ", arg.get("kill"))
	
	player.set_kill_stat(kill)
	player.set_marry_stat(marry)
	player.set_kiss_stat(kiss)
	
	Dialogic.signal_event.disconnect(get_signal_event)

func gift():
	if(player.get_inventory().size() == 0):
		return
	else:
		player.choose_gift()

func finish_giving_gift(giftName):
	if(name == 'Azazael'):
		if(giftName ==beatingHeartItemType.name):
			var like = beatingHeartItemType.azazael_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == holyWater.name):
			var like = holyWater.azazael_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == blueTeddyBear.name):
			var like = blueTeddyBear.azazael_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == pigeonBloodRuby.name):
			var like = pigeonBloodRuby.azazael_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == preservedHaggish.name):
			var like = preservedHaggish.azazael_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
	elif(name == 'Gos'):
		if(giftName ==beatingHeartItemType.name):
			var like = beatingHeartItemType.gos_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == holyWater.name):
			var like = holyWater.gos_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == blueTeddyBear.name):
			var like = blueTeddyBear.gos_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == pigeonBloodRuby.name):
			var like = pigeonBloodRuby.gos_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == preservedHaggish.name):
			var like = preservedHaggish.gos_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
	elif(name == 'Dolore'):
		if(giftName == beatingHeartItemType.name):
			var like = beatingHeartItemType.dolore_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == holyWater.name):
			var like = holyWater.dolore_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == blueTeddyBear.name):
			var like = blueTeddyBear.dolore_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == pigeonBloodRuby.name):
			var like = pigeonBloodRuby.dolore_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
		elif(giftName == preservedHaggish.name):
			var like = preservedHaggish.dolore_liking
			if(like == Liking.NONE):
				return
			elif(like == Liking.HATE):
				Dialogic.VAR.set("Gift", 2)
			elif(like == Liking.LOVE):
				Dialogic.VAR.set("Gift", 0)
			elif(like == Liking.NEUTRAL):
				Dialogic.VAR.set("Gift", 1)
	start_dial(choose_gift())
			

func choose_gift(): # To override
	pass

func ended():
	player.enable_movements()
	player.unpause_pentagrams()
	player.canTalkAfterTimer.start()
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
	Dialogic.VAR.set("Souls", player.getSoulNumber())
	Dialogic.start("caveDialog")

func caveEnded():
	player.timeUi.hide()
	Dialogic.signal_event.disconnect(caveEvent)
	Dialogic.timeline_ended.disconnect(caveEnded)
	
	player.enable_movements()
	player.unpause_pentagrams()
	player.canTalkAfterTimer.start()

func caveEvent(event):
	if(event == "resetAzazael"):
		player.removeSouls(10)
		emit_signal("sig_azazael")
		print("resetAzazael")

	if(event == "resetGos"):
		player.removeSouls(10)
		emit_signal("sig_gos")
		print("resetGos")
	if(event == "resetDolore"):
		player.removeSouls(10)
		emit_signal("sig_dolore")
		print("resetDolore")
	if(event == 'nothing'):
		print("nothing")

func add_to_stat(statName, value):
	if statName == 'kiss':
		kiss += value
		if(kiss > 100):
			kiss = 100
		if(kiss < 0):
			kiss = 0
		print("Kiss for: ", name, ' is now', kiss, ' and was', kiss - value)
	elif statName == 'marry':
		marry += value
		if(marry > 100):
			marry = 100
		if(marry < 0):
			marry = 0
		print("Marry for: ", name, ' is now', kiss, ' and was', kiss - value)
	elif statName == 'kill':
		kill += value
		if(kill > 100):
			kill = 100
		if(kill < 0):
			kill = 0
		print("kill for: ", name, ' is now', kiss, ' and was', kiss - value)
	else:
		print("Stat not found")
		return
