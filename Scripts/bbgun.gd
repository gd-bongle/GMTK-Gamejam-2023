extends RigidBody3D

func activate(_b):
	var bodies = $blast.get_overlapping_bodies()
	
	for m in bodies:
		if m.has_method("shoot"):
			m.shoot();

func reveal():
	pass
