extends Node2D

export (PackedScene) var Cat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var b1
var b2
var up = true


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.RaceBGM.stop()
	Global.TitleBGM.stop()
	Global.PodiumBGM.play()
	var cat1 = Cat.instance()
	add_child(cat1)
	cat1.position = $"1st".position
	cat1.start(Global.rng, Global.winner, Global.winner == Global.player_no, true)
	var cat2 = Cat.instance()
	add_child(cat2)
	cat2.position = $"2nd".position
	cat2.start(Global.rng, Global.second, Global.second == Global.player_no, true)
	var cat3 = Cat.instance()
	add_child(cat3)
	cat3.position = $"3rd".position
	cat3.start(Global.rng, Global.third, Global.third == Global.player_no, true)
	
	$balloon.position.x = randf() * 200 + 156
	$balloon.position.y = randf() * 200 + 64
	b1 = $balloon.position
	$balloon2.position.x = randf() * 200 + 156 + 512
	$balloon2.position.y = randf() * 200 + 64
	b2 = $balloon2.position
	if b1.y < b2.y:
		up = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $balloon.position.y < b1.y - 32:
		up = false
	elif $balloon.position.y > b1.y + 32:
		up = true
	if up:
		$balloon.position.y -= 0.1
		$balloon2.position.y += 0.1
	else:
		$balloon.position.y += 0.1
		$balloon2.position.y -= 0.1

	$sky.position.x -= 1
	if $sky.position.x <= -2048:
		$sky.position.x = 2048
	
	$sky2.position.x -= 1
	if $sky2.position.x <= -2048:
		$sky2.position.x = 2048

func _on_Restart_pressed():
	get_tree().change_scene("res://CatSelect.tscn")


func _on_MainMenu_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
