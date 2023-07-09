extends RigidBody3D

var revealed: bool = false

func reveal():
	if !revealed:
		print("secret!")
		$key/Key.get_active_material(0).emission_enabled = true
		$key/Key.get_active_material(0).emission = Color.CHOCOLATE
		var tween = create_tween()
		tween.tween_property($key/Key.get_active_material(0), "emission_energy_multiplier", 1.0, 0.5)
		freeze = false
		revealed = true

func activate(body):
	if body.has_method("open"):
		body.open()
