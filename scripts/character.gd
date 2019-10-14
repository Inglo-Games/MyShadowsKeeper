extends KinematicBody2D
class_name Player

# Constants
const MOVE_SPEED : int = 400
const JUMP_SPEED : int = -600
const GRAVITY : Vector2 = Vector2(0, 980)

# Scene elements
onready var sprite = $self_sprite
onready var shadow = $shadow_sprite

# State variables
var velocity : Vector2 = Vector2()


func _physics_process(delta : float):
	
	# Handle gravity
	velocity += delta * GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Handle player input
	var direction : int = 0
	if Input.is_action_pressed("move_right"):
		direction += MOVE_SPEED
	if Input.is_action_pressed("move_left"):
		direction -= MOVE_SPEED
	velocity.x = lerp(velocity.x, direction, 0.1)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
	
	move_shadow()

func move_shadow():
	shadow.global_position.x = sprite.global_position.x
	shadow.global_position.y = sprite.global_position.y * -1
