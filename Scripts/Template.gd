extends Node3D

var pivot

func _ready():
	pivot = $Pivot
	$BGM.play()

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
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://Scenes/Level1.tscn"))

func _on_timer_timeout():
	$TutorialText.queue_free()
