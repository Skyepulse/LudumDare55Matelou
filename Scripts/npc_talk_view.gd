extends Control

var dialogLabel
var nameLabel
var dialogRect
var nameRect
var dialogTimer:Timer
var keepDialogTimer:Timer
const OFFSET = 0
const DIALOG_SPEED = 0.05
const DIALOG_KEEP_TIME = 2

var toBeSaidDialog = ""
var saidDialog = ""
var currentIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogRect = $dialogRect
	nameRect = $nameRect
	dialogLabel = $dialogRect/DialogueLabel
	nameLabel = $nameRect/NameLabel
	dialogLabel.text = ""
	nameLabel.text = "Hello Hello Hello Hello Hello Hello"
	initialize_label_position()

	dialogTimer = Timer.new()
	dialogTimer.set_wait_time(DIALOG_SPEED)
	dialogTimer.set_one_shot(false)
	dialogTimer.timeout.connect(on_continue_dialog)
	add_child(dialogTimer)

	keepDialogTimer = Timer.new()
	keepDialogTimer.set_wait_time(DIALOG_KEEP_TIME)
	keepDialogTimer.timeout.connect(on_hide_dialog)
	add_child(keepDialogTimer)

	talk_dialog("Hello my name is Bob. I am a very cool guy! This is a test for a dialog method to show on screen dynamically!")

func initialize_label_position():
	var dialogLabelMinSize = dialogLabel.get_minimum_size()
	dialogRect.set_custom_minimum_size(Vector2(dialogLabelMinSize.x, dialogLabelMinSize.y + OFFSET))
	nameRect.global_position.y = dialogRect.global_position.y - 2*nameRect.size.y
	var nameLabelMinSize = nameLabel.get_minimum_size()
	nameRect.set_custom_minimum_size(Vector2(nameLabelMinSize.x, nameLabelMinSize.y))

func _on_dialogue_label_resized():
	updateLabelPositions()

func updateLabelPositions():
	if(dialogLabel == null || nameLabel == null):
		return
	var dialogLabelMinSize = dialogLabel.get_minimum_size()
	dialogRect.set_custom_minimum_size(Vector2(dialogLabelMinSize.x, dialogLabelMinSize.y + OFFSET))
	nameRect.global_position.y = dialogRect.global_position.y - 2*nameRect.size.y
	var nameLabelMinSize = nameLabel.get_minimum_size()
	nameRect.set_custom_minimum_size(Vector2(nameLabelMinSize.x, nameLabelMinSize.y))
	

func _process(_delta):
	if(Input.is_action_just_pressed("interact")):
		dialogLabel.text += " pressed"


func talk_dialog(text):
	toBeSaidDialog = text
	currentIndex = 0
	saidDialog = toBeSaidDialog[currentIndex]
	dialogLabel.text = saidDialog
	dialogTimer.start()

func on_continue_dialog():
	if(currentIndex < toBeSaidDialog.length() - 1):
		currentIndex += 1
		saidDialog += toBeSaidDialog[currentIndex]
		dialogLabel.text = saidDialog
	else:
		dialogTimer.stop()
		saidDialog = ""
		toBeSaidDialog = ""
		currentIndex = 0
		keepDialogTimer.start()

func on_hide_dialog():
	dialogLabel.text = ""
	keepDialogTimer.stop()