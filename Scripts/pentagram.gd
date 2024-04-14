extends Area2D

const PENTAGRAM_RADIUS = 16
const PENTAGRAM_SCALE = 5.2

@onready var sprite : Sprite2D = $Sprite2D
var tileMap = preload("res://Scenes/map_main_node.tscn")

func _ready() -> void:
	#connect the body and the pentagram
	body_entered.connect(_on_body_entered)
	get_parent().scale = Vector2(PENTAGRAM_SCALE,PENTAGRAM_SCALE)
	get_node("CollisionShape2D").shape.radius = PENTAGRAM_RADIUS


func _on_body_entered(body: Node2D) -> void:
	#when player enters pentagram do something and spin the pentagram away
	var player := body as CharacterBody2D
	if not player :
		get_parent().queue_free()
		return
		
	show()
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", -20.0, .5)
	tween.parallel().tween_property(sprite, "rotation_degrees", -360.0, .5)
	tween.tween_callback(queue_free)


