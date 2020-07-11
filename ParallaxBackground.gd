extends Container


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport().size
	for node in get_children():
		node.rect_position.x = randf() * screen_size.x + screen_size.x
		node.rect_position.y = randf() * screen_size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in get_children():
		node.rect_position.x = node.rect_position.x - 3
		if node.rect_position.x < -400:
			node.rect_position.x = screen_size.x + randf() * 500
			node.rect_position.y = randf() * screen_size.y
