extends Sprite2D

@export var max_stretch: float = 0.4
@export var speed_for_max: float = 600.0
@export var vertical_influence: float = 1.0
@export var smoothing: float = 12.0

@onready var body: CharacterBody2D = $"../.."
@onready var visual: Node2D = $".."
@onready var base_scale: Vector2 = visual.scale

func _physics_process(delta: float) -> void:
	var vel: Vector2 = body.velocity

	var h_speed: float = abs(vel.x)
	var v_speed: float = abs(vel.y)

	var h_factor: float = clamp(h_speed / speed_for_max, 0.0, 1.0)
	var v_factor: float = clamp(v_speed / speed_for_max, 0.0, 1.0)

	# Horzontal
	var stretch_x: float = 1.0 + h_factor * max_stretch
	var squash_y: float = 1.0 - h_factor * max_stretch * 0.5

	# Verticasl
	var stretch_y: float = 1.0 + v_factor * max_stretch * vertical_influence
	var squash_x: float = 1.0 - v_factor * max_stretch * 0.5

	var target_scale: Vector2 = Vector2(
		base_scale.x * stretch_x * squash_x,
		base_scale.y * stretch_y * squash_y
	)

	visual.scale = visual.scale.lerp(
		target_scale,
		1.0 - exp(-smoothing * delta)
	)
