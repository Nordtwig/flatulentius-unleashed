extends Node3D

@export var speed : float = 20.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
			position.y += delta * speed
	
	if Input.is_action_pressed("ui_left"):
		rotate_z(delta)
	
	if Input.is_action_pressed("ui_right"):
		rotate_z(-delta)