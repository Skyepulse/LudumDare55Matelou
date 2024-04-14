extends Area2D

const PENTAGRAM_RADIUS = 16
const PENTAGRAM_SCALE = 5.2

@onready var sprite : Sprite2D = $Sprite2D
var tileMap = preload("res://Scenes/map_main_node.tscn")
var stayTimer: Timer

var instanceID = 0
var stayTime = 0

var rotation_speed = 5
var acceleration = 100


func set_stay_time(time : float) -> void:
	stayTime = time
	stayTimer.set_wait_time(time)
	stayTimer.start()
	

func get_stay_time() -> float:
	return stayTime

func set_id(id : int) -> void:
	instanceID = id

func get_id() -> int:
	return instanceID

func _ready() -> void:
	#connect the body and the pentagram
	body_entered.connect(_on_body_entered)
	get_parent().scale = Vector2(PENTAGRAM_SCALE,PENTAGRAM_SCALE)
	get_node("CollisionShape2D").shape.radius = PENTAGRAM_RADIUS
	stayTimer = Timer.new()
	stayTimer.timeout.connect(die)
	add_child(stayTimer)

func _on_body_entered(body: Node2D) -> void:
	#when player enters pentagram do something and spin the pentagram away
	var player := body as CharacterBody2D
	if not player :		
		get_tree().get_root().get_node("mainScene").get_node("pentagram_spawner").remove_pentagram(get_id())
		get_parent().queue_free()
		return
		
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", -20.0, .5)
	tween.parallel().tween_property(sprite, "rotation_degrees", -360.0, .5)
	get_tree().get_root().get_node("mainScene").get_node("pentagram_spawner").remove_pentagram(get_id())
	tween.tween_callback(queue_free)

func die():
	get_tree().get_root().get_node("mainScene").get_node("pentagram_spawner").remove_pentagram(get_id())
	get_parent().queue_free()


func _process(delta):
	if(stayTimer.is_stopped()): return
	rotation_speed += acceleration * delta
	sprite.rotation_degrees += rotation_speed * delta
