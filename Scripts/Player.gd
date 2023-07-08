extends CharacterBody3D

const SPEED = 8.0

var tween
var held_item

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= SPEED * delta
	
	var cam_rot = (1.0 if Input.is_action_pressed("z") else 0.0) - (1.0 if Input.is_action_pressed("c") else 0.0)
	
	transform.basis = transform.basis.rotated(Vector3.UP, 5.0 * delta * cam_rot)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("w", "s", "d", "a")
#	var rot_dir = (1.0 if Input.is_action_pressed("q") else 0.0) - (1.0 if Input.is_action_pressed("e") else 0.0)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if (velocity.length() > 0):
		var look = position + velocity
		$Holder.look_at(Vector3(look.x, 0, look.z))
	
	move_and_slide()
	apply_floor_snap()

func _process(_delta):
	if Input.is_action_just_pressed("rightclick"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			if b and b.is_in_group("pickup") and !$Holder/Hand.get_children().has(b):
				pickup(b)
				break;
	elif Input.is_action_just_pressed("leftclick") and held_item and held_item.has_method("activate"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			held_item.activate(b)
				
	if Input.is_action_just_pressed("x"):
		var bodies = $PickupArea.get_overlapping_bodies()
		for b in bodies:
			if b.has_method("press"):
				b.press()
				
func pickup(thing: RigidBody3D):
	if $Holder/Hand.get_child_count() > 0:
		for c in $Holder/Hand.get_children():
			c.reparent(get_owner())
			c.set_position($Holder/Drop.get_position())
			c.freeze = false
			
	thing.reparent($Holder/Hand)
	thing.freeze = true
	thing.set_rotation_degrees(Vector3(180, 0, 0))
	thing.set_position(Vector3.ZERO)
	held_item = thing

func kill():
	print("owie!")
	set_physics_process(false)
	var dtween = get_tree().create_tween()
	dtween.tween_property($Holder/PC, "scale", Vector3.ONE * 0.001, 1.0)
	dtween.tween_callback(get_tree().reload_current_scene)
