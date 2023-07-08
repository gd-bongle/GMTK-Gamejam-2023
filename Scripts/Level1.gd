extends Node3D

var pivot

func _ready():
	pivot = $Pivot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rot_dir = (1.0 if Input.is_action_pressed("z") else 0.0) - (1.0 if Input.is_action_pressed("c") else 0.0)
	
	pivot.set_rotation(Vector3(0, pivot.get_rotation().y + 5.0 * delta * rot_dir, 0))

func _on_end_button_pressed():
	for f in get_children():
		if f.is_in_group("flashlight"):
			f.queue_free()
			
	var tween = get_tree().create_tween()
	tween.tween_property($WorldEnvironment.environment, "ambient_light_energy", 0, 2.0)



func _on_generator_generator_broken():
	$TrailerLights.monitoring = false
	var death_tween = create_tween().set_parallel()
	death_tween.tween_property($TrailerLights/CollisionShape3D2/SpotLight3D, "light_energy", 0, 0.5)
	death_tween.tween_property($WorldGeo/camp4/Window1.get_active_material(1), "emission_energy_multiplier", 0, 0.5)
	death_tween.tween_property($TrailerLights/CollisionShape3D/SpotLight3D, "light_energy", 0, 0.5)
	death_tween.set_parallel(false)
	death_tween.tween_callback($TrailerLights.queue_free)
