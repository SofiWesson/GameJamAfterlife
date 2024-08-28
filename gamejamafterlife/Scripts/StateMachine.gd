extends Node

@onready var playState: Node = $PlayState
@onready var buildState: Node = $BuildState

var stateStack: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#process start up of states
	playState.Start()
	buildState.Start()
	#hide states
	remove_child(playState)
	remove_child(buildState)
	#default state is playState, change later
	add_child(playState)
	stateStack.push_back(playState)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#changes between build and play mode
	if Input.is_action_just_pressed("ChangeState"):
		if stateStack[0] == playState:
			ChangeToBuildMode()
		else:
			ChangeToPlayMode()
	#process current states update
	stateStack[0].Update()

func ChangeToPlayMode():
	#adds play state to the stack
	stateStack.push_back(playState)
	ChangeMode()
	print("play mode")

func ChangeToBuildMode():
	#adds build state to the stack
	stateStack.push_back(buildState)
	ChangeMode()
	print("build mode")

func ChangeMode():
	#disable current state and enable new state
	remove_child(stateStack[0])
	add_child(stateStack.back())
	#remove current state
	stateStack.pop_front()
