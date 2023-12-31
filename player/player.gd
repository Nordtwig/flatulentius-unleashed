extends RigidBody3D 

@export var thrust : float = 1500.0
@export var agility : float = 100.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
			apply_central_force(basis.y * delta * thrust)	
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, agility * delta))	
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -agility * delta))

func _on_body_entered(body:Node) -> void:
	if "goal" in body.get_groups():
		print(body.name)
	elif "hazard" in body.get_groups():
		print("You crashed and burned!")