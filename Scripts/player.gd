extends CharacterBody2D

@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = 400.0
@export var jump :bool = true
@export var fallGraV : float = 0.3
@export var grav : float = 1
var FinalGrav: float

@onready var anim: Sprite2D = $Sprite/Sprite

func _ready() -> void:
	up_direction = Vector2.UP

func _physics_process(delta: float) -> void:

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta * FinalGrav

		if velocity.y > 0:
			FinalGrav = fallGraV
		else:
			FinalGrav = grav
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
	

	if Input.is_action_just_pressed("UP") and is_on_floor() and jump:
		velocity.y = -JUMP_VELOCITY
		print("jump")

	# Horizontal movement
	var direction := Input.get_axis("LEFT", "RIGHT")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	move_and_slide()

	if is_on_wall() and Input.is_action_just_pressed("WALLJUMP") and jump:
		velocity.y = -JUMP_VELOCITY
