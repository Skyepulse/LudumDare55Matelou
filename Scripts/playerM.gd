extends CharacterBody2D

const SPEED = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	velocity = Vector2()  # Reset velocity

	# Check for input and modify velocity accordingly
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	velocity = velocity.normalized() * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body:Node2D):
	print("Detected: ", body.name)


func _on_area_2d_body_exited(body:Node2D):
	print("Exited detection of: ", body.name)

