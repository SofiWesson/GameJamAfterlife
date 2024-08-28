extends Node

@onready var playState: Node = $PlayState
@onready var buildState: Node = $BuildState

var stateStack: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stateStack.push_back(playState)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ChangeState"):
		if stateStack[0] == playState:
			ChangeToBuildMode()
		else:
			ChangeToPlayMode()

	stateStack[0].Update()

func ChangeToPlayMode():
	stateStack.push_back(playState)
	ChangeMode()
	print("play mode")

func ChangeToBuildMode():
	stateStack.push_back(buildState)
	ChangeMode()
	print("build mode")

func ChangeMode():
	stateStack[0].process_mode = Node.PROCESS_MODE_DISABLED
	stateStack.back().process_mode = Node.PROCESS_MODE_PAUSABLE
	stateStack.pop_front()