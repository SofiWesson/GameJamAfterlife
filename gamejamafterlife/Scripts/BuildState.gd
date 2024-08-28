extends Node

var world: Node

var currentSelection: Node

var testPlaceableScene: Resource
var testPlaceable: Node

func Start():
	world = get_tree().get_root()
	testPlaceableScene = load("res://Scenes/testPlaceable.tscn")
	testPlaceable = testPlaceableScene.instantiate()
	add_child(testPlaceable)

	currentSelection = testPlaceable

func Update():
	currentSelection.position = GetMouseToWorldPosition()

func GetMouseToWorldPosition() -> Vector3:
	#clean up, comment
	var viewport := get_viewport()
	var mousePosition := viewport.get_mouse_position()
	var camera := viewport.get_camera_3d()

	var origin := camera.project_ray_origin(mousePosition)
	var direction := camera.project_ray_normal(mousePosition)

	var rayLength = camera.far
	var end = origin + direction * rayLength

	var query = PhysicsRayQueryParameters3D.create(origin, end, 1)
	var result = viewport.get_world_3d().direct_space_state.intersect_ray(query)

	return result.get("position", end)