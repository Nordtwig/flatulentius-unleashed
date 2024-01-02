extends RigidBody3D 

## How much vertical force to apply when moving.
@export_range(100.0, 3000.0)  var thrust : float = 1200.0

## How much torque to apply when rotating.
@export_range(5.0, 200.0) var torque : float = 80.0

@onready var explosion_audio = $ExplosionAudio
@onready var success_audio = $SuccessAudio
@onready var rocket_audio = $RocketAudio
@onready var booster_particles = $BoosterParticles
@onready var right_booster_particles = $RightBoosterParticles
@onready var left_booster_particles = $LeftBoosterParticles

var is_transitioning: bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
			apply_central_force(basis.y * delta * thrust)	
			booster_particles.emitting = true
			if rocket_audio.playing == false:
				rocket_audio.play()
	else:
		booster_particles.emitting = false
		rocket_audio.stop()

	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque * delta))	
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false 
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque * delta))
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false 

func crash_sequence() -> void:
	print("Kaboom!")
	explosion_audio.play()
	set_physics_process(false)
	is_transitioning = true
	# await get_tree().create_timer(1.5).timeout
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) -> void:
	print("You win!")
	success_audio.play()
	set_physics_process(false)
	is_transitioning = true
	# await get_tree().create_timer(1.5).timeout
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))

# SIGNAL LISTENERS
func _on_body_entered(body:Node) -> void:
	if is_transitioning:
		return 
	if "goal" in body.get_groups():
		complete_level(body.file_path)	
	elif "hazard" in body.get_groups():
		crash_sequence()	