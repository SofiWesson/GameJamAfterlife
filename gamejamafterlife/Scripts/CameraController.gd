extends Node3D

const speed = 10.0
const zoomSpeed = 10.0

@onready var camera: Camera3D = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CameraMovement(delta)
	CameraZoom(delta)

func CameraMovement(delta: float):
	var moveDirection := Vector3.ZERO
	# which direction on both axis to move along
	moveDirection.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	moveDirection.z = Input.get_action_strength("MoveBackward") - Input.get_action_strength("MoveForward")
	# move in direction in local space
	position += moveDirection.z * transform.basis.z.normalized() * speed * delta
	position += moveDirection.x * transform.basis.x.normalized() * speed * delta

func CameraZoom(delta: float):
	# zooms camera in and out when scrolling in local space
	if Input.is_action_just_pressed("ZoomIn"):
		camera.position -= camera.transform.basis.z.normalized() * zoomSpeed * delta
	if Input.is_action_just_pressed("ZoomOut"):
		camera.position += camera.transform.basis.z.normalized() * zoomSpeed * delta
