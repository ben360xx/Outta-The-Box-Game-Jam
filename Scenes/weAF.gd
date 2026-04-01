extends Node2D

@onready var manager: Node2D = $".."
@onready var crt: ColorRect = $"../../../../CRT"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	manager.Next_scene = "res://Scenes/Tutorial.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		pass #make it quit
	
