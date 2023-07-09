extends StaticBody3D

signal generator_broken

func destroy():
	print("bonk!")
	emit_signal("generator_broken")
