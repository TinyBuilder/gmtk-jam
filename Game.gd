extends Node2D

export (PackedScene) var Fish
export (PackedScene) var Cat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cats = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for _i in range(8):
		var cat = Cat.instance()
		add_child(cat)
		cats.append(cat)
		cat.start($StartPosition.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
   # Mouse in viewport coordinates
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.is_pressed() :
		print("Mouse Click ", event.position)
		var fish = Fish.instance()
		add_child(fish)
		fish.position = event.position
		print("Fish spawned")
		fish.connect("fish_spawn", cats[0], "add_target")
		fish.spawn()
