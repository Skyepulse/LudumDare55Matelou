extends Node2D
@onready var time = $Timer
var frequency = 2.0

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
		
func random_pos(position):
	#select a random cell around the player
	var randomx = rng.randf_range(-128.0, 128.0)
	#make sure it doesn't spawn on the player
	
	var randomy = rng.randf_range(-128.0, 128.0)
	#make sure it doesn't spawn on the player
	
	print (Vector2(position.x+randomx, position.y+randomy), position)
	return Vector2(position.x+randomx, position.y+randomy)
	
func inst(pos : Vector2) -> void :
	#generate random position around player
	var rand_pos = random_pos(pos)
	#choose big or small pentagram with 1/10 odds
	var rand_pentagram_size = rng.randi_range(0,10)
	
	#instantiate the pentagram
	if rand_pentagram_size<10:
		var instance = pentagram.instantiate()
		instance.position = rand_pos
		add_child(instance)
	else:
		var instance = big_pentagram.instantiate()
		instance.position = rand_pos
		add_child(instance)
		
# Called when the node enters the scene tree for the first time.


func _on_timer_timeout():
	inst(player.global_position)

	
