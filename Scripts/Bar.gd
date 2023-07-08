extends RigidBody3D

func activate(b):
	if b.has_method("destroy"):
		b.destroy()
