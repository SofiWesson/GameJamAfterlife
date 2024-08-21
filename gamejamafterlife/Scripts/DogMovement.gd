extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D

var speed = 3.0

func _physics_process(delta: float) -> void:
	var currentLocation = global_transform.basis
	var nextLocation = navAgent.get_next_location()
	var newVelocity = (nextLocation - currentLocation).normalized() * speed

	velocity = newVelocity
	move_and_slide()

func update_target_location(target_location):
	navAgent.set_target_location(target_location)
