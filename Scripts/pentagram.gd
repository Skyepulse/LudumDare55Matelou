extends Area2D

@onready var sprite : Sprite2D = $Sprite2D
var tileMap = preload("res://Scenes/map_main_node.tscn")

func _ready() -> void:
	#connect the body and the pentagram
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	#when player enters pentagram do something and spin the pentagram away
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", -20.0, .5)
	tween.parallel().tween_property(sprite, "rotation_degrees", -360.0, .5)
	tween.tween_callback(queue_free)


