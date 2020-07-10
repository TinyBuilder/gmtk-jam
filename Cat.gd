extends Area2D


# Declare member variables here. Examples:
const MAX_SPEED = 400
const MAX_WAIT = 5.0
export var speed = 0
var screen_size
var rng = RandomNumberGenerator.new()
var targets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()

func idle():
	$Timer.start(rng.randf_range(0.0, MAX_WAIT))
	self.evaluate()

func add_target(target):
	targets.append(target)

func evaluate():
	pass
