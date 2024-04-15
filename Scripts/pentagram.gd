extends Area2D

const PENTAGRAM_RADIUS = 8
const BIG_PENTAGRAM_RADIUS = 16
const PENTAGRAM_SCALE = 10.4
const PENTAGRAM_Z_INDEX = 1

@onready var sprite : Sprite2D = $Sprite2D
@onready var playerCharacter:CharacterBody2D = get_tree().get_root().get_node("mainScene").get_node("CharacterBody2D")
var tileMap = preload("res://Scenes/map_main_node.tscn")
var stayTimer: Timer

var instanceID = 0
var stayTime = 0

var rotation_speed = 5
var acceleration = 100

var isPlayerInside: bool = false

var isBig:bool = false

func set_is_big(isBig : bool) -> void:
	self.isBig = isBig

var colorTileMapPositionSmall = [0, 16, 32]
var colorTileMapPositionBig = [48, 80, 112]

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

func set_radius(radius : float) -> void:
	get_node("CollisionShape2D").shape.radius = radius

func set_sprite_texture(type:String) -> void:
	if(type == "big"):
		self.sprite.texture.region.position.x = colorTileMapPositionBig[randi() % 3]
	else:
		self.sprite.texture.region.position.x = colorTileMapPositionSmall[randi() % 3]

func _ready() -> void:
	#connect the body and the pentagram
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	get_parent().scale = Vector2(PENTAGRAM_SCALE,PENTAGRAM_SCALE)
	get_node("CollisionShape2D").shape.radius = PENTAGRAM_RADIUS

	stayTimer = Timer.new()
	stayTimer.timeout.connect(die)
	add_child(stayTimer)

	z_index = PENTAGRAM_Z_INDEX

	var new_texture = sprite.texture.duplicate()
	sprite.texture = new_texture

func _on_body_entered(body: Node2D) -> void:
	var player := body as CharacterBody2D
	if not player :		
		return
	print('Player entered')
	isPlayerInside = true

func _on_body_exited(body: Node2D) -> void:
	var player := body as CharacterBody2D
	if not player :		
		return
		
	isPlayerInside = false

func die():
	if(isPlayerInside):
		print('TELEPORTED')
	get_tree().get_root().get_node("mainScene").get_node("pentagram_spawner").remove_pentagram(get_id())
	get_parent().queue_free()


func _process(delta):
	if(stayTimer.is_stopped()): return
	rotation_speed += acceleration * delta
	sprite.rotation_degrees += rotation_speed * delta
