extends CharacterBody2D
class_name Player

@export var camera:Camera2D

@onready var walkIdleTexture:Texture = preload("res://media/main_char/main_char_front.png")
@onready var walkIdleTextureBack:Texture = preload("res://media/main_char/main_char_back.png")
@onready var walkIdleTextureLeft:Texture = preload("res://media/main_char/mainchar_walking_front_1.png")
@onready var walkIdleTextureRight:Texture = preload("res://media/main_char/mainchar_walking_front_2.png")
@onready var sprite = $Sprite2D

var dash_wing_ui: PackedScene = preload("res://Scenes/dash_wing_ui.tscn")
var stats_ui: PackedScene = preload("res://Scenes/stats_control.tscn")
var corvee_ui: PackedScene = preload("res://Scenes/teleported_view_scene.tscn")
var kmk_ui: PackedScene = preload("res://Scenes/kmk_control.tscn")
var time_ui: PackedScene = preload("res://Scenes/time_left_view.tscn")
const SPEED = 500
const DASH_RECOVERY_TIME = 3
const DASH_NUM = 3
const PLAYER_Z_INDEX = 2
var dashNum = DASH_NUM
var dashTimer:Timer
var dashRecoveryTimer:Timer
var dashSpeed = 1
var nearNPC:Node2D = null 
var dashWingUi
var statsUi
var kmkUi
var corveeUi
var timeUi
var isInCorvee = false

var inventory = {}
var id = 0

func get_inventory():
	return inventory

func add_to_inventory(objname):
	if objname in inventory:
		inventory[objname] += 1
	else:
		inventory[objname] = 1
	print(inventory)
	update_inventory_ui()

func remove_from_inventory(objname):
	if objname in inventory:
		inventory[objname] -= 1
		if inventory[objname] == 0:
			inventory.erase(objname)
	update_inventory_ui()

func update_inventory_ui():
	dashWingUi.update_inventory(inventory)

var changeTextureTimer:Timer

var soulsNumber = 0

func getSoulNumber():
	return soulsNumber

func addSouls(numSouls:int):
	soulsNumber += numSouls
	dashWingUi.update_souls(soulsNumber)
	print("Souls: " + str(soulsNumber))

func removeSouls(numSouls:int):
	soulsNumber -= numSouls
	dashWingUi.update_souls(soulsNumber)
	print("Souls: " + str(soulsNumber))

var pentagramEsquiveCount = 0

func setPentagramEsquiveCount(value:int):
	pentagramEsquiveCount = value

func getPentagramEsquiveCount():
	return pentagramEsquiveCount

var pentagramEsquiveMax = 0

func setPentagramEsquiveMax(value:int):
	pentagramEsquiveMax = value

func getPentagramEsquiveMax():
	return pentagramEsquiveMax

var numCorveesDone = 0

func getNumCorveesDone():
	return numCorveesDone

func addCorveeDone():
	numCorveesDone += 1

@onready var pentagram_spawner = $'../pentagram_spawner'

var pentagramsPaused = false

var blocked:bool = false;

var talkLabel:Label

var sceneCanvasLayer:CanvasLayer
#Bitmap value for layer 3
const NPC_LAYER = 1 << 2

var current_npc: NPC = null

var canTalkAfterTimer:Timer

#kiss marry kill stats
var KISS_STAT = 20
var MARRY_STAT = 20
var KILL_STAT = 30

signal kiss_changed
signal marry_changed
signal kill_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	dashTimer = Timer.new()
	dashTimer.wait_time = 0.2
	dashTimer.timeout.connect(_on_dash_timer_timeout)
	add_child(dashTimer)

	dashRecoveryTimer = Timer.new()
	dashRecoveryTimer.wait_time = DASH_RECOVERY_TIME
	dashRecoveryTimer.timeout.connect(_on_dash_recovery_timer_timeout)
	add_child(dashRecoveryTimer)

	talkLabel = $Label
	dashWingUi = dash_wing_ui.instantiate()
	sceneCanvasLayer = get_tree().get_root().get_node("mainScene").get_node("SceneCanvasLayer")
	sceneCanvasLayer.add_child(dashWingUi)

	statsUi = stats_ui.instantiate()
	sceneCanvasLayer.add_child(statsUi)
	statsUi.hide()
	
	kmkUi = kmk_ui.instantiate()
	sceneCanvasLayer.add_child(kmkUi)
	kmkUi.hide()
	kmkUi.player = self

	corveeUi = corvee_ui.instantiate()
	sceneCanvasLayer.add_child(corveeUi)
	corveeUi.hide()
	corveeUi.player = self

	timeUi = time_ui.instantiate()
	sceneCanvasLayer.add_child(timeUi)
	timeUi.hide()
	timeUi.player = self

	z_index = PLAYER_Z_INDEX

	canTalkAfterTimer = Timer.new()
	canTalkAfterTimer.wait_time = 1
	canTalkAfterTimer.timeout.connect(_on_can_talk_after_timer_timeout)
	add_child(canTalkAfterTimer)

	changeTextureTimer = Timer.new()
	changeTextureTimer.wait_time = 0.3
	changeTextureTimer.timeout.connect(_on_change_texture_timer_timeout)
	add_child(changeTextureTimer)
	changeTextureTimer.start()


func _process(_delta):
	velocity = Vector2()  # Reset velocity

	var has_pressed = false
	# Check for input and modify velocity accordingly
	
	if Input.is_action_pressed("move_down"):
		if(!has_pressed): has_pressed = true
		changeTextureTimer.paused = false
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		if(!has_pressed): has_pressed = true
		changeTextureTimer.paused = false
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		if(!has_pressed): has_pressed = true
		changeTextureTimer.paused = false
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		if(!has_pressed): has_pressed = true
		sprite.texture = walkIdleTextureBack
		changeTextureTimer.paused = true
		velocity.y -= 1

	if(!has_pressed):
		sprite.texture = walkIdleTexture
		changeTextureTimer.paused = true
		
	

	velocity = velocity.normalized() * SPEED * dashSpeed

	if Input.is_action_just_pressed("dash") and dashTimer.is_stopped() and dashNum > 0:
		if(!has_pressed): return
		dashSpeed = 2			
		dashNum -= 1
		dashTimer.start()
		if(dashRecoveryTimer.is_stopped()): dashRecoveryTimer.start()
		dashWingUi.update_dash(dashNum)
	
	if not blocked:
		move_and_slide()
	#we update the camera position
	move_camera()
	update_talk_label()
	if(not blocked and Input.is_action_just_pressed("interact") and nearNPC != null and !isInCorvee):
		print("Interacting with NPC")
		nearNPC.talk()
	if(not blocked and Input.is_action_just_pressed("gift") and nearNPC != null and !isInCorvee):
		print("Interacting with NPC")
		nearNPC.gift()

func move_camera():
	#We implement a small lag for the camera to follow the player
	camera.position = camera.position.lerp(position, 0.07)

func _on_area_2d_body_entered(body:Node2D):
	var bodyPhysicLayer = body.collision_layer
	if(bodyPhysicLayer == NPC_LAYER):
		#If we don't have a near NPC we set it
		if(nearNPC == null):
			nearNPC = body.get_parent()
		else:
			#If we have a near NPC we check if the new one is closer
			var distanceOld = position.distance_to(nearNPC.position)
			var distanceNew = position.distance_to(body.get_parent().position)
			if(distanceNew < distanceOld):
				nearNPC = body.get_parent()

func _on_area_2d_body_exited(body:Node2D):
	#First we check if there is another NPC near, if not we set it to null, if there is we set it to the closest one by default
	#We check all objects in the area to see if there is another NPC
	if(body.collision_layer != NPC_LAYER): return
	var area = get_node("Area2D")
	var bodies = area.get_overlapping_bodies()
	if(bodies.size() == 0):
		nearNPC = null
		return
	var closestDistance = 0
	var npc = null
	for b in bodies:
		if(b.collision_layer == NPC_LAYER):
			if(closestDistance == 0):
				npc = b.get_parent()
				closestDistance = position.distance_to(npc.position)
			else:
				var distance = position.distance_to(b.get_parent().position)
				if(distance < closestDistance):
					closestDistance = distance
					npc = b.get_parent()
	nearNPC = npc

func _on_dash_timer_timeout():
	dashSpeed = 1
	dashTimer.stop()


func _on_dash_recovery_timer_timeout():
	dashNum += 1
	if(dashNum==DASH_NUM): dashRecoveryTimer.stop()
	dashWingUi.update_dash(dashNum)

func get_area2D_node_path():
	var nodePath = get_node("Area2D").get_path()
	return nodePath

func update_talk_label():
	if(nearNPC == null):
		talkLabel.text = ""
		talkLabel.visible = false
	else:
		if(nearNPC.name == 'Cave Of Lost Souls'): 
			talkLabel.text = "Press E to interact with" + nearNPC.name + " (" + str(soulsNumber) + " souls)"
			talkLabel.visible = true
		else:
			talkLabel.text = "Press E to talk to " + nearNPC.name + "! And G to gift!"
			talkLabel.visible = true

func block_movements():
	blocked = true
	kmkUi.show()
	hide_dash_wing_ui()
	show_stats_ui()
func enable_movements():
	blocked = false
	kmkUi.hide()
	hide_stats_ui()
	show_dash_wing_ui()

func hide_dash_wing_ui():
	dashWingUi.hide()

func show_dash_wing_ui():
	dashWingUi.show()

func hide_stats_ui():
	statsUi.hide()

func show_stats_ui():
	statsUi.show()

func set_kill_stat(value):
	KILL_STAT=min(value,100)
	kill_changed.emit()

func set_kiss_stat(value):
	KISS_STAT=min(value,100)
	kiss_changed.emit()
	
func set_marry_stat(value):
	MARRY_STAT=min(value,100)
	marry_changed.emit()

func pause_pentagrams():
	pentagramsPaused = true
	pentagram_spawner.pause_spawner()
	var pentagrams = pentagram_spawner.instances
	for pentagram_id in pentagrams:
		var pentagram = pentagrams[pentagram_id]
		var controller = pentagram.find_children('*_pentagram')[0]

		controller.pause_pentagram()

func unpause_pentagrams():
	pentagramsPaused = false
	pentagram_spawner.unpause_spawner()
	var pentagrams = pentagram_spawner.instances
	for pentagram_id in pentagrams:
		var pentagram = pentagrams[pentagram_id]
		var controller = pentagram.find_children('*_pentagram')[0]

		controller.resume_pentagram()

func startCorvee():
	isInCorvee = true
	corveeUi.show()
	dashWingUi.hide()
	destroy_all_pentagrams()
	pause_pentagrams()
	block_movements()
	corveeUi.start_dialog()


func onCorveeFinished():
	addCorveeDone()
	corveeUi.hide()
	show_dash_wing_ui()
	unpause_pentagrams()
	enable_movements()
	canTalkAfterTimer.start()

func _on_can_talk_after_timer_timeout():
	canTalkAfterTimer.stop()
	canTalkAfterTimer.wait_time = 1
	isInCorvee = false

func destroy_all_pentagrams():
	pentagram_spawner.destroy_all_pentagrams()

func _on_change_texture_timer_timeout():
	if(sprite.texture == walkIdleTextureLeft):
		sprite.texture = walkIdleTextureRight
	else:
		sprite.texture = walkIdleTextureLeft
	changeTextureTimer.start()

func choose_gift():
	print('here')
	isInCorvee = true
	pause_pentagrams()
	block_movements()
	statsUi.hide()
	kmkUi.hide()
	dashWingUi.show()
	dashWingUi.choose_gift()

func finished_choosing_gift(nname):
	unpause_pentagrams()
	enable_movements()
	canTalkAfterTimer.start()
	if(inventory.has(nname)):
		inventory[nname] -= 1
		if(inventory[nname] == 0):
			inventory.erase(nname)
	update_inventory_ui()
	nearNPC.finish_giving_gift(nname)