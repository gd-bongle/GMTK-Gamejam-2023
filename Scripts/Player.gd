extends CharacterBody3D

const SPEED = 8.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("w", "s", "d", "a")
	var rot_dir = (1.0 if Input.is_action_pressed("q") else 0.0) - (1.0 if Input.is_action_pressed("e") else 0.0)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	$Holder.set_rotation(Vector3(0, $Holder.get_rotation().y + SPEED * delta * rot_dir * 0.5, 0))

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("rightclick"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("pickup") and !$Holder/Hand.get_children().has(b):
				pickup(b)
				break;
				
	if Input.is_action_just_pressed("x"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("pressable"):
				b.press()
				
func pickup(thing: RigidBody3D):
	if $Holder/Hand.get_child_count() > 0:
		for c in $Holder/Hand.get_children():
			get_owner().add_child(c)
			c.set_position(get_position())
			c.freeze = false
			
	thing.get_owner().remove_child(thing)
	$Holder/Hand.add_child(thing)
	thing.freeze = true
	thing.set_rotation_degrees(Vector3(180, 0, 0))
	thing.set_position(Vector3.ZERO)

func kill():
	print("owie!")
	set_physics_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property($Holder/PC, "scale", Vector3.ONE * 0.001, 1.0)
	tween.tween_callback(get_tree().reload_current_scene)
