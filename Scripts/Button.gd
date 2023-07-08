extends StaticBody3D

signal pressed

func press():
	emit_signal("pressed")
