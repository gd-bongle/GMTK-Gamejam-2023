extends StaticBody3D

signal pressed

var _pressed = false

func press():
	emit_signal("pressed")
	_pressed = true


func _on_label_collision_area_entered(area):
	if _pressed == false:
		$Text.visible = true


func _on_label_collision_area_exited(area):
	print("yee")
	$Text.visible = false
