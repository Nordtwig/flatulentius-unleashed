extends RigidBody3D 

@export var thrust : float = 1500.0
@export var agility : float = 100.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
			apply_central_force(basis.y * delta * thrust)	
	
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0.0, 0.0, agility * delta))	
	
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0.0, 0.0, -agility * delta))