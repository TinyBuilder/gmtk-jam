extends Node2D

export (PackedScene) var Cat
export (PackedScene) var Cage

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.TitleBGM.playing:
		Global.RaceBGM.stop()
		Global.PodiumBGM.stop()
		Global.TitleBGM.play()
	for i in range(8):
		var cage = Cage.instance()
		var cat = Cat.instance()
		var is_player = false
		if i == Global.player_no:
			is_player = true
		add_child(cat)
		add_child(cage)
		var pos = $Position2D.position
		pos.y += i*64
		cage.position = pos
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


func _on_Back_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_LinkButton1_mouse_entered():
	$Profile.text = "Tebi is prone to being easily distracted, but so is every other cat in the race so she's not really special."


func _on_LinkButton2_mouse_entered():
	$Profile.text = "Despite his name, Huge is no bigger than any other cat in the race. He also likes frogs a lot."


func _on_LinkButton3_mouse_entered():
	$Profile.text = "Sam was meme'd out of retirement and now greatly regrets it."


func _on_LinkButton4_mouse_entered():
	$Profile.text = "Cairo's unique colours and stripes give off an air of royalty, although some people think her stripes are painted on."


func _on_LinkButton5_mouse_entered():
	$Profile.text = "Don't trust Jeremy."


func _on_LinkButton6_mouse_entered():
	$Profile.text = "It is a cruel irony that she is called Meringue as she can't eat sweets on account of being a cat, and also diabetic."


func _on_LinkButton7_mouse_entered():
	$Profile.text = "Baron: When I grow up, I want to be a Doberman!"


func _on_LinkButton8_mouse_entered():
	$Profile.text = "Train gives off an air of danger, as if he was important in one of his nine lives."
