extends Node2D
@onready var time = $Timer
var frequency = 2.0

const PENTAGRAM_RADIUS = 16
const PENTAGRAM_SCALE = 5.2
#to create some pentagrams in the scene

var pentagram = preload("res://Scenes/pentagram_scene.tscn")
var big_pentagram = preload("res://Scenes/pentagram_scene.tscn")
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
		
func random_pos(position, pentagram_size):
	var randomx = 0.0
	var randomy = 0.0
	var safety_diameter = 200.0
	var spawn_range = 256.0
	if (pentagram_size == "big"):
		safety_diameter = 350.0
		spawn_range = 400.0
	while (Vector2(position.x+randomx,position.y+randomy).distance_to(position)<200.0):
		#select a random cell around the player
		randomx = rng.randf_range(-spawn_range, spawn_range)
		randomy = rng.randf_range(-spawn_range, spawn_range)
	
	#make sure it doesn't spawn on the player
	print (Vector2(position.x+randomx, position.y+randomy), position)
	return Vector2(position.x+randomx, position.y+randomy)
	
func inst(pos : Vector2) -> void :
	#choose big or small pentagram with 1/10 odds
	var rand_pentagram_size = rng.randi_range(0,11)
	print(rand_pentagram_size)
	
	if rand_pentagram_size<10:
			#generate random position around player
		var rand_pos = random_pos(pos,"small")
		


		#instantiate the pentagram
		var instance = pentagram.instantiate()
		instance.position = rand_pos
		instance.hide()
		add_child(instance)
	else:
			#generate random position around player
		var rand_pos = random_pos(pos,"big")
		
			#instantiate the pentagram
		var instance = big_pentagram.instantiate()
		instance.hide()
		instance.position = rand_pos
		print("intstance big")
		add_child(instance)


func _on_timer_timeout():
	inst(player.global_position)

	
