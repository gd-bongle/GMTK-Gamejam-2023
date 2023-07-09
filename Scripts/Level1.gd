extends Node3D

var pivot
var generator = true
var campfire = true

func _ready():
	pivot = $Pivot
	$BGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rot_dir = (1.0 if Input.is_action_pressed("z") else 0.0) - (1.0 if Input.is_action_pressed("c") else 0.0)
	
	pivot.set_rotation(Vector3(0, pivot.get_rotation().y + 5.0 * delta * rot_dir, 0))

func _on_generator_generator_broken():
	generator = false
	$TrailerLights.monitoring = false
	var death_tween = create_tween().set_parallel()
	death_tween.tween_property($TrailerLights/CollisionShape3D2/SpotLight3D, "light_energy", 0, 0.5)
	death_tween.tween_property($WorldGeo/camp4/Window1.get_active_material(1), "emission_energy_multiplier", 0, 0.5)
	death_tween.tween_property($TrailerLights/CollisionShape3D/SpotLight3D, "light_energy", 0, 0.5)
	death_tween.set_parallel(false)
	death_tween.tween_callback($TrailerLights.queue_free)
	
	if (!campfire):
		end_level()


func _on_door_opening():
	$WorldGeo/camp4/Lock.queue_free()
	$bbgun.freeze = false
	$bbgun/CollisionShape3D.disabled = false
	$bbgun/bbgun/BBgun.get_active_material(0).emission_enabled = true;
	$bbgun/bbgun/BBgun.get_active_material(0).emission_energy_multiplier = 1.0
	$bbgun/bbgun/BBgun.get_active_material(0).emission = Color.BROWN


func _on_water_shot():
	campfire = false;
	var tween = get_tree().create_tween().set_parallel()
	$Campfire.monitoring = false
	tween.tween_property($Campfire/OmniLight3D, "light_energy", 0, 1.0)
	tween.tween_property($WorldGeo/camp4/Fire.get_active_material(0), "emission_energy_multiplier", 0, 1.0)
	tween.set_parallel(false)
	
	if (!generator):
		end_level()
	
func end_level():
	var removal = get_children()
	for f in removal:
		if f.is_in_group("flashlight") or f.has_method("reveal"):
			f.queue_free()
			
	$Player/SpotLight3D.queue_free()
	$Player/Holder/Hand.get_child(0).queue_free()
	var tween = create_tween()
	$Success.play()
	tween.tween_property($WorldEnvironment.environment, "ambient_light_energy", 0, 2.0)
