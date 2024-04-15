extends Node2D
@onready var time = $Timer
var frequency = 2.0

const PENTAGRAM_RADIUS = 16
const PENTAGRAM_SCALE = 5.2
#to create some pentagrams in the scene

var pentagramPosList = {}
var index = 0

var pentagram = preload("res://Scenes/small_pentagram_scene.tscn")
var big_pentagram = preload("res://Scenes/big_pentagram_scene.tscn")
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
	return Vector2(position.x+randomx, position.y+randomy)
	
func inst(pos : Vector2) -> void :	
	#generate random position around player
	var rand_pos = random_pos(pos,"small")
	
	if(!can_instantiate_object(rand_pos, PENTAGRAM_RADIUS + 1, PENTAGRAM_SCALE)): 
		print("Can't instantiate object")
		return

	#instantiate the pentagram
	var instance = pentagram.instantiate()
	instance.position = rand_pos
	add_child(instance)
	instance.get_node("small_pentagram").set_id(index)
	instance.get_node("small_pentagram").set_stay_time(5)
	pentagramPosList[index] = rand_pos
	index += 1
	print(pentagramPosList)


func _on_timer_timeout():
	inst(player.global_position)

func can_instantiate_object(pos, radius, object_scale):
	var space_state = get_world_2d().direct_space_state
	var query1 = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(0, 1).normalized() * radius * object_scale)
	var query2 = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(1, 0).normalized() * radius * object_scale)
	var query3 = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(0, -1).normalized() * radius * object_scale)
	var query4 = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(-1, 0).normalized() * radius * object_scale)

	var query5 = PhysicsRayQueryParameters2D.create(pos + Vector2(0, 1).normalized() * radius * object_scale, pos)
	var query6 = PhysicsRayQueryParameters2D.create(pos + Vector2(1, 0).normalized() * radius * object_scale, pos)
	var query7 = PhysicsRayQueryParameters2D.create(pos + Vector2(0, -1).normalized() * radius * object_scale, pos)
	var query8 = PhysicsRayQueryParameters2D.create(pos + Vector2(-1, 0).normalized() * radius * object_scale, pos)

	var result1 = space_state.intersect_ray(query1)
	var result2 = space_state.intersect_ray(query2)
	var result3 = space_state.intersect_ray(query3)
	var result4 = space_state.intersect_ray(query4)
	var result5 = space_state.intersect_ray(query5)
	var result6 = space_state.intersect_ray(query6)
	var result7 = space_state.intersect_ray(query7)
	var result8 = space_state.intersect_ray(query8)

	for result in [result1, result2, result3, result4, result5, result6, result7, result8]:
		if(result == {}): continue
		var collider = result.collider
		if(collider):
			print(collider.get_parent().name)
			return false

	for pentagram_pos_id in pentagramPosList:
		if pentagramPosList[pentagram_pos_id].distance_to(pos) < (PENTAGRAM_RADIUS + 0.5) * PENTAGRAM_SCALE * 2:
			return false
	return true

func remove_pentagram(pentagram_id):
	pentagramPosList.erase(pentagram_id)
