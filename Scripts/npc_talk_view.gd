extends Control

var dialogLabel
var nameLabel
const OFFSET = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogLabel = $dialogRect.get_child(0)
	nameLabel = $nameRect.get_child(0)
	dialogLabel.text = "Hello World"
	nameLabel.text = name


func _on_dialogue_label_resized():
	updateLabelPositions()

func updateLabelPositions():
	if(dialogLabel == null):
		return
	var dialogLabelHeight = dialogLabel.get_content_height()
	nameLabel.position.y = dialogLabel.position.y - dialogLabelHeight

func _process(_delta):
	if(Input.is_action_just_pressed("interact")):
		dialogLabel.text += "pressed"