extends Node3D

const speed = 10.0
const zoomSpeed = 10.0

@onready var camera: Camera3D = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#Input.is_action_just_released("ZoomIn"):
		#camera.position.z -= transform.basis.z * zoomSpeed * delta
	#if Input.is_action_pressed("ZoomOut"):
	#	camPos.z -= zoomSpeed * delta
	#position = to_global(pos)

func _physics_process(delta: float) -> void:
	var moveDirection := Vector3.ZERO
	moveDirection.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	moveDirection.z = Input.get_action_strength("MoveBackward") - Input.get_action_strength("MoveForward")
	if Input.is_action_pressed("MoveForward"):
		position -= transform.basis.z.normalized() * speed * delta
	if Input.is_action_pressed("MoveBackward"):
		position += transform.basis.z.normalized() * speed * delta
	if Input.is_action_pressed("MoveRight"):
		position += transform.basis.x.normalized() * speed * delta
	if Input.is_action_pressed("MoveLeft"):
		position -= transform.basis.x.normalized() * speed * delta