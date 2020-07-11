extends Area2D


# Declare member variables here. Examples:
const MAX_SPEED = 100
const MAX_WAIT = 3.0
var velocity = Vector2()
var screen_size
var rng
var targets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(random):
	print(self.name)
	rng = random
	show()
	self.idle()

func idle():
	$Timer.start(rng.randf_range(0.0, MAX_WAIT))

class TargetSorter:
	func prioritise_target(a, b):
		var d1 = a.global_position.distance_to(self.global_position)
		var d2 = b.global_position.distance_to(self.global_position)
		if d1 < d2:
			 return true
		return false

func add_target(target):
	targets.append(target)

func remove_target(target):
	targets.erase(target)

func evaluate():
	if rng.randf_range(0.0, 10.0) < 9.0:
		var speed = rng.randf() * MAX_SPEED
		
		if targets.size() > 0 and rng.randf_range(0.0, 10.0) < 9.0:
			targets.sort_custom(TargetSorter, "prioritise_target")
			velocity.x = targets[0].global_position.x - self.position.x
			velocity.y = targets[0].global_position.y - self.position.y
		else:
			velocity.x = rng.randf_range(-1.0, 1.0)
			velocity.y = rng.randf_range(-1.0, 1.0)
		
		velocity = velocity.normalized() * speed
		$Timer.start(rng.randf_range(0.0, MAX_WAIT))
		if velocity.x > 0:
			$AnimatedSprite.set_flip_h(false)
		else:
			$AnimatedSprite.set_flip_h(true)	
		$AnimatedSprite.play("walk")
	else:
		velocity.x = 0
		velocity.y = 0
		self.idle()

func _on_Timer_timeout():
	self.evaluate()

func _process(delta):
	self.position += velocity * delta
	self.position.x = clamp(self.position.x, 0, screen_size.x)
	self.position.y = clamp(self.position.y, 0, screen_size.y)
