extends Sprite

signal cucumber_spawn(threat)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn():
	emit_signal("cucumber_spawn", self)
	$Timer.start(rand_range(5.0, 10.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
