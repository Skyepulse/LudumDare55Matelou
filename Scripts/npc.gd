extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func talk():
	print("Hello World")

func _on_dialogue_label_resized():
	updateLabelPositions()

func updateLabelPositions():
	nameLabel.rect_position.y = dialogueLabel.rect_position.y - nameLabel.rect_size.y + OFFSET