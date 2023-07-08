extends Node3D

var pivot

func _ready():
	pivot = $Pivot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rot_dir = (1.0 if Input.is_action_pressed("z") else 0.0) - (1.0 if Input.is_action_pressed("c") else 0.0)
	
	pivot.set_rotation(Vector3(0, pivot.get_rotation().y + 5.0 * delta * rot_dir, 0))
