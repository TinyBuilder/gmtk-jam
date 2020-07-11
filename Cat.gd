extends KinematicBody2D


# Declare member variables here. Examples:
const MAX_SPEED = 100
const MAX_WAIT = 3.0
var velocity = Vector2()
var screen_size
var rng
var targets = []
var threats = []
var is_chasing = false
var is_eating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start(random, is_player):
	rng = random
	show()
	$AnimatedSprite.play("walk")
	if is_player:
		$Player.play("player")
	#elif is_player == null:
	#	$Player.hide()
	else:
		$Player.play("cpu")
	idle()

func idle():
	is_chasing = false
	velocity.x = 0
	velocity.y = 0
	$Timer.start(rng.randf_range(1.0, MAX_WAIT))

func prioritise_target(a, b):
	var d1 = a.global_position.distance_to(global_position)
	var d2 = b.global_position.distance_to(global_position)
	if d1 < d2:
		 return true
	return false

func add_target(target):
	targets.append(target)

func remove_target(target, eater):
	if is_chasing and targets.size() > 0 and target == targets[0]:
		targets.erase(target)
		if eater == self:
			$AnimatedSprite.play("eat")
			idle()
		else:
			evaluate()
	else:
		targets.erase(target)


func add_threat(threat):
	if threat.global_position.distance_to(global_position) < 50 and rng.randf_range(0.0, 10.0) < 7.5:
		var speed = rng.randf_range(1.5, 2.0) * MAX_SPEED
		velocity.x = global_position.x - threat.global_position.x
		velocity.y = global_position.y - threat.global_position.y
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
		$Timer.start(rng.randf_range(0.5, 1.0))

func evaluate():
	if rng.randf_range(0.0, 10.0) < 9.0:
		var speed = rng.randf() * MAX_SPEED
		
		if targets.size() > 0:
			targets.sort_custom(self, "prioritise_target")
			
			if targets[0].global_position.distance_to(global_position) < 200 and rng.randf_range(0.0, 10.0) < 9.0:
				is_chasing = true
				velocity.x = targets[0].global_position.x - global_position.x
				velocity.y = targets[0].global_position.y - global_position.y
			else:
				is_chasing = false
				velocity.x = rng.randf_range(-1.0, 1.0)
				velocity.y = rng.randf_range(-1.0, 1.0)
		else:
			is_chasing = false
			velocity.x = rng.randf_range(-1.0, 1.0)
			velocity.y = rng.randf_range(-1.0, 1.0)
		
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
		$Timer.start(rng.randf_range(0.0, MAX_WAIT))
		
	else:
		$AnimatedSprite.play("sleep")
		idle()

func _on_Timer_timeout():
	evaluate()

func _process(delta):
	if velocity.x > 0:
		$AnimatedSprite.set_flip_h(false)
	elif velocity.x < 0:
		$AnimatedSprite.set_flip_h(true)	
	move_and_slide(velocity)
