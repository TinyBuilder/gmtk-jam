extends Node2D

export (PackedScene) var Cat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(8):
		var cat = Cat.instance()
		var is_player = false
		if i == Global.player_no:
			is_player = true
		add_child(cat)
		var pos = $Position2D.position
		if i < 4:
			pos.y += i*96
		else:
			pos.y += (i-4)*96
			pos.x += 512
		cat.position = pos
		cat.start(Global.rng, i, null, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LinkButton1_pressed():
	Global.player_no = 0
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton2_pressed():
	Global.player_no = 1
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton3_pressed():
	Global.player_no = 2
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton4_pressed():
	Global.player_no = 3
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton5_pressed():
	Global.player_no = 4
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton6_pressed():
	Global.player_no = 5
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton7_pressed():
	Global.player_no = 6
	get_tree().change_scene("res://Game.tscn")


func _on_LinkButton8_pressed():
	Global.player_no = 7
	get_tree().change_scene("res://Game.tscn")
