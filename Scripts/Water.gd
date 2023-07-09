extends StaticBody3D

signal shot

func shoot():
	emit_signal("shot")
