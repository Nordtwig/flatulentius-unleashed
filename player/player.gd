extends RigidBody3D 

## How much vertical force to apply when moving.
@export_range(100.0, 3000.0)  var thrust : float = 1200.0

## How much torque to apply when rotating.
@export_range(5.0, 200.0) var torque : float = 80.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
			apply_central_force(basis.y * delta * thrust)	
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque * delta))	
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque * delta))

func crash_sequence() -> void:
	print("Kaboom!")
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()

func complete_level(next_level_file: String) -> void:
	print("You win!")
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file(next_level_file)

# SIGNAL LISTENERS
func _on_body_entered(body:Node) -> void:
	if "goal" in body.get_groups():
		complete_level(body.file_path)	
	elif "hazard" in body.get_groups():
		crash_sequence()	