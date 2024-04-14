extends Node2D

#to create some pentagrams in the scene

var pentagram = preload("res://Scenes/pentagram_scene.tscn")
@onready var tileMap = $'mapMainNode/TileMap'

func _physics_process(delta):
	if Input.is_action_just_pressed("test_pent"):
		var pos : Vector2 = Vector2(get_global_mouse_position())
		inst(pos)
	
func inst(pos : Vector2) -> void :
	print("instantiating")
	var instance = pentagram.instantiate()
	instance.position = pos
	add_child(instance)

