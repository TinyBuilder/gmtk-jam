extends Node2D

export (PackedScene) var Fish
export (PackedScene) var Cat
export (PackedScene) var Cucumber

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MAX_CATS = 8
var cats = []
var player_no = 0

var crosshair = load("res://Sprites/retical.png")

var fish_ready = true
var cucumber_ready = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#Input.set_custom_mouse_cursor(crosshair)
	
	$FishHUD.play("default")
	$CucumberHUD.play("default")
	
	for i in range(MAX_CATS):
		var cat = Cat.instance()
		var is_player = false
		if i == player_no:
			is_player = true
		add_child(cat)
		cats.append(cat)
		var pos = $StartPosition.position
		pos.y -= i*32
		cat.position = pos
		cat.start(Global.rng, is_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.name.match("**Cat****"):
		var second = cats[0]
		var third = cats[0]
		for cat in cats:
			if cat.global_position.x > second.global_position.x:
				second = cat
			elif cat.global_position.x > third.global_position.x:
				third = cat
		Global.winner = cats.find(body)
		Global.second = cats.find(second)
		Global.third = cats.find(third)
		get_tree().change_scene("res://Podium.tscn")



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
		elif event.get_button_index() == 2:
			var cucumber = Cucumber.instance()
			add_child(cucumber)
			cucumber.position = event.position
			for i in range(MAX_CATS):
				cucumber.connect("cucumber_spawn", cats[i], "add_threat")
			cucumber.spawn()
			cucumber_ready = false
			$CucumberHUD.play("loading")
			$CucumberTimer.start()
