extends Node2D
@onready var time = $Timer
var frequency = 2.0

#to create some pentagrams in the scene

var pentagram = preload("res://Scenes/pentagram_scene.tscn")
@onready var tileMap : TileMap =$'../mapMainNode/TileMap'
@onready var player = $'../CharacterBody2D'
var rng = RandomNumberGenerator.new()

func _ready():
	#set the timer
	time.start(frequency)
	#timer restarts when it is done
	time.one_shot = false

func _physics_process(delta):
	#testing
	if Input.is_action_just_pressed("test_pent"):
		#instantiate the pentagram
		var pos = player.global_position
		inst(pos)
		
func random_pos(position):
	#select a random cell around the player
	var randomx = rng.randf_range(-128.0, 128.0)
	#make sure it doesn't spawn on the player
	if randomx<0:
		randomx-=240
		print(randomx)
		print(position.x)
	else:
		print(randomx)
		print(position.x)
		randomx+=240
	var randomy = rng.randf_range(-128.0, 128.0)
	#make sure it doesn't spawn on the player
	if randomy<0:
		randomx-=240
	else:
		randomy+=240
	print (Vector2(position.x+randomx, position.y+randomy), position)
	return Vector2(position.x+randomx, position.y+randomy)
	
func inst(pos : Vector2) -> void :
	#generate random position around player
	var rand_pos = random_pos(pos)
	
	#instantiate the pentagram
	var instance = pentagram.instantiate()
	instance.position = rand_pos
	add_child(instance)
# Called when the node enters the scene tree for the first time.


func _on_timer_timeout():
	inst(player.global_position)

	
