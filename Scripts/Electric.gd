extends StaticBody3D

var node_mat
var shot = false
var zapping = false

func _ready():
	node_mat = $"templepillar/electric/Electric Device/Icosphere".get_active_material(0)
	node_mat.emission = Color.ALICE_BLUE

func kill():
	$templepillar/electric/LittleZap.play()
	node_mat.emission_enabled = true
	node_mat.emission_energy_multiplier = 1.0
	zapping = true
	await get_tree().create_timer(0.5).timeout
	if !shot:
		zapping = false
		node_mat.emission_enabled = false
		node_mat.emission_energy_multiplier = 0.0
		
func shoot():
	if zapping:
		$templepillar/electric/BigZap.play()
		shot = true
