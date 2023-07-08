extends CharacterBody3D

const SPEED = 5.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var rot_dir = (1.0 if Input.is_action_pressed("q") else 0.0) - (1.0 if Input.is_action_pressed("e") else 0.0)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	set_rotation(Vector3(0, get_rotation().y + SPEED * delta * rot_dir, 0))

	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("rightclick"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("pickup"):
				pickup(b)
				break;
				
func pickup(thing: RigidBody3D):
	if $Hand.get_child_count() > 0:
		for c in $Hand.get_children():
			get_owner().add_child(c)
			c.set_position(get_position())
			c.freeze = false
			
	thing.get_owner().remove_child(thing)
	$Hand.add_child(thing)
	thing.freeze = true
	thing.set_rotation_degrees(Vector3(180, 0, 0))
	thing.set_position(Vector3.ZERO)
