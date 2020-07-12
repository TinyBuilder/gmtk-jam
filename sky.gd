extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport().size
	for node in get_children():
		node.position.x = randf() * screen_size.x
		node.position.y = randf() * 150


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in get_children():
		node.position.x = node.position.x - 1
		if node.position.x < -100:
			node.position.x = screen_size.x + randf() * screen_size.x
			node.position.y = randf() * 150
