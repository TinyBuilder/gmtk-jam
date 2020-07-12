extends Node2D

export (PackedScene) var Fish
export (PackedScene) var Cat
export (PackedScene) var Cucumber

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MAX_CATS = 8
var cats = []

var crosshair = load("res://Sprites/retical.png")

var fish_ready = false
var cucumber_ready = false
var started = false
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.TitleBGM.stop()
	Global.PodiumBGM.stop()
	Global.RaceBGM.play()
	#Input.set_custom_mouse_cursor(crosshair)
	
	$FishHUD.play("default")
	$CucumberHUD.play("default")
	
	for i in range(MAX_CATS):
		var cat = Cat.instance()
		var is_player = false
		if i == Global.player_no:
			is_player = true
		add_child(cat)
		cats.append(cat)
		var pos = $StartPosition.position
		pos.y -= i*32
		cat.position = pos
		cat.z_index = 2
		cat.start(Global.rng, i, is_player, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started:
		$CenterContainer/Label.text = str(ceil($StartCountdown.time_left))
	var front = 0
	var lead = 0
	for cat in cats:
		if cat.position.x > front:
			lead = cat.id
			front = cat.position.x
	Global.front = front
	Global.lead = lead

func _on_Area2D_body_entered(body):
	if finished:
		return
	if body.name.match("**Cat****"):
		finished = true
		var winner = body.id
		var second = 0
		var third = 0
		if winner == 0:
			second = 1
			third = 1
		for i in range(cats.size()):
			if i != body.id:
				if cats[i].global_position.x > cats[second].global_position.x:
					third = second
					second = i
				elif cats[i].global_position.x > cats[third].global_position.x:
					third = i
		Global.winner = winner
		Global.second = second
		Global.third = third
		$CenterContainer.show()
		$CenterContainer/Label.text = "Cat " + str(winner + 1) + " wins!"
		$EndTimer.start()

func _on_FishTimer_timeout():
	fish_ready = true
	$FishHUD.play("default")


func _on_CucumberTimer_timeout():
	cucumber_ready = true
	$CucumberHUD.play("default")


func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() :
		if event.get_button_index() == 1 and fish_ready:
			var fish = Fish.instance()
			add_child(fish)
			fish.position = event.position
			for i in range(MAX_CATS):
				fish.connect("fish_spawn", cats[i], "add_target")
				fish.connect("fish_eaten", cats[i], "remove_target")
			fish.spawn()
			fish_ready = false
			$FishHUD.play("loading")
			$FishTimer.start()
		elif event.get_button_index() == 2 and cucumber_ready:
			var cucumber = Cucumber.instance()
			add_child(cucumber)
			cucumber.position = event.position
			for i in range(MAX_CATS):
				cucumber.connect("cucumber_spawn", cats[i], "add_threat")
			cucumber.spawn()
			cucumber_ready = false
			$CucumberHUD.play("loading")
			$CucumberTimer.start()

func _on_StartCountdown_timeout():
	fish_ready = true
	$CucumberHUD.play("loading")
	$CucumberTimer.start()
	$CenterContainer.hide()
	$Gun.play()
	started = true


func _on_EndTimer_timeout():
	get_tree().change_scene("res://Podium.tscn")
