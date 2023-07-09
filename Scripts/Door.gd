extends StaticBody3D

signal opening
var opened: bool = false

func open():
	if !opened:
		emit_signal("opening")
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, 45, 0), 1.0)
		opened = true
