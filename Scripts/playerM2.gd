extends CharacterBody2D
class_name Player

@export var camera:Camera2D

var dash_wing_ui: PackedScene = preload("res://Scenes/dash_wing_ui.tscn")
var stats_ui: PackedScene = preload("res://Scenes/stats_control.tscn")
const SPEED = 500
const DASH_RECOVERY_TIME = 3
const DASH_NUM = 3
var dashNum = DASH_NUM
var dashTimer:Timer
var dashRecoveryTimer:Timer
var dashSpeed = 1
var nearNPC:Node2D = null 
var dashWingUi
var statsUi

var talkLabel:Label

var sceneCanvasLayer:CanvasLayer
#Bitmap value for layer 3
const NPC_LAYER = 1 << 2

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



func _process(_delta):
	velocity = Vector2()  # Reset velocity

	var has_pressed = false
	# Check for input and modify velocity accordingly
	if Input.is_action_pressed("move_up"):
		if(!has_pressed): has_pressed = true
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		if(!has_pressed): has_pressed = true
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		if(!has_pressed): has_pressed = true
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		if(!has_pressed): has_pressed = true
		velocity.x += 1
	

	velocity = velocity.normalized() * SPEED * dashSpeed

	if Input.is_action_pressed("dash") and dashTimer.is_stopped() and dashNum > 0:
		if(!has_pressed): return
		dashSpeed = 2			
		dashNum -= 1
		dashTimer.start()
		if(dashRecoveryTimer.is_stopped()): dashRecoveryTimer.start()
		dashWingUi.update_dash(dashNum)
			
	move_and_slide()
	#we update the camera position
	move_camera()
	update_talk_label()
	if(Input.is_action_just_pressed("interact") and nearNPC != null):
		nearNPC.talk()

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
				nearNPC = body

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


func update_talk_label():
	if(nearNPC == null):
		talkLabel.text = ""
		talkLabel.visible = false
	else:
		talkLabel.text = "Press E to talk to " + nearNPC.name + "!"
		talkLabel.visible = true

func hide_dash_wing_ui():
	dashWingUi.hide()

func show_dash_wing_ui():
	dashWingUi.show()

func hide_stats_ui():
	statsUi.hide()

func show_stats_ui():
	statsUi.show()

func add_kill_stat(value):
	KILL_STAT=max(value+KILL_STAT,100)
	kill_changed.emit()

func add_kiss_stat(value):
	KISS_STAT=max(value+KISS_STAT,100)
	kiss_changed.emit()
	
func add_marry_stat(value):
	MARRY_STAT=max(value+MARRY_STAT,100)
	marry_changed.emit()
