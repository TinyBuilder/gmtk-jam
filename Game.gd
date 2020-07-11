extends Node2D

export (PackedScene) var Fish
export (PackedScene) var Cat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MAX_CATS = 8
var cats = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for _i in range(MAX_CATS):
		var cat = Cat.instance()
		add_child(cat)
		cats.append(cat)
		var pos = $StartPosition.position
		pos.x += rng.randf_range(-10.0, 10.0)
		pos.y += rng.randf_range(-10.0, 10.0)
		cat.position = pos
		cat.start(rng)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
   # Mouse in viewport coordinates
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.is_pressed() :
		var fish = Fish.instance()
		add_child(fish)
		fish.position = event.position
		for i in range(MAX_CATS):
			fish.connect("fish_spawn", cats[i], "add_target")
			fish.connect("fish_eaten", cats[i], "remove_target")
		fish.spawn()
