extends Node3D

func _on_button_pressed():
	var tween = get_tree().create_tween()
	$Area3D.set_monitoring(false)
	tween.tween_property($OmniLight3D, "light_energy", 0, 1.0)
	tween.tween_callback(queue_free)


func _on_end_button_pressed():
	queue_free()
