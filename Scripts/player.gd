extends CharacterBody2D

@export var SPEED : float = 200.0
@export var KICKBACK : float = 700.0
@export var JUMP_VELOCITY : float = 400.0
@export var jump :bool = false
@export var walljump :bool = true
@export var invertMovement :bool = false
@export var gun :bool = false
@export var fallGraV : float = 0.3
@export var grav : float = 1
var FinalGrav: float
@onready var manager: Node2D = $"../.."

@onready var anim: Sprite2D = $Sprite/Sprite

func _ready() -> void:
	up_direction = Vector2.UP
	FinalGrav = grav
	if not gun:
		get_node("Gun").hide()
func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		if velocity.y > 0:
			FinalGrav = fallGraV
		else:
			FinalGrav = grav

		velocity += get_gravity() * delta * FinalGrav


	# Sprite Flip
	if velocity.x < 0:
		$Sprite/Sprite.scale.x=-1
	elif velocity.x > 0:
		$Sprite/Sprite.scale.x=1


	# Jump
	if Input.is_action_just_pressed("UP") and is_on_floor() and jump:
		velocity.y = -JUMP_VELOCITY
		print("jump")


	# Wall Jump (midair only, pushes away from wall)
	if is_on_wall() and !is_on_floor() and Input.is_action_just_pressed("UP"):
		if !walljump:
			return

		var wall_normal = get_wall_normal()

		velocity.y += -JUMP_VELOCITY
		velocity.x = wall_normal.x * SPEED * 2


	# Horizontal movement
	if !invertMovement: 
		var direction := Input.get_axis("LEFT", "RIGHT")

		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		var direction := Input.get_axis("LEFT", "RIGHT")

		if direction != 0:
			velocity.x = -direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


	# Gun Kickback
	if Input.is_action_just_pressed("SHOOT") and gun:
		var mouse_direction = global_position.direction_to(get_global_mouse_position())
		velocity += -mouse_direction * KICKBACK
		get_parent().get_node("GunSound").play()


	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	gun = true
	get_node("Gun").show()
	get_parent().get_node("Gun").queue_free()


func _on_key_area_body_entered(body: Node2D) -> void:
	print()

func _on_pass_jump_sign(body: Node2D) -> void:
	jump = !jump # Replace with function body.
