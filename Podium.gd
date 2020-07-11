extends Node2D

export (PackedScene) var Cat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var cat1 = Cat.instance()
	add_child(cat1)
	cat1.position = $"1st".position
	cat1.start(Global.rng, true, true)
	var cat2 = Cat.instance()
	add_child(cat2)
	cat2.position = $"2nd".position
	cat2.start(Global.rng, false, true)
	var cat3 = Cat.instance()
	add_child(cat3)
	cat3.position = $"3rd".position
	cat3.start(Global.rng, false, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Restart_pressed():
	get_tree().change_scene("res://Game.tscn")
