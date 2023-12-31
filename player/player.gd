extends RigidBody3D 

## How much vertical force to apply when moving.
@export_range(100.0, 3000.0)  var thrust : float = 1200.0

## How much torque to apply when rotating.
@export_range(5.0, 200.0) var torque : float = 80.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
			apply_central_force(basis.y * delta * thrust)	
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque * delta))	
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque * delta))

func _on_body_entered(body:Node) -> void:
	if "goal" in body.get_groups():
		print(body.name)
	elif "hazard" in body.get_groups():
		print("You crashed and burned!")