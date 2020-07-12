extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.TitleBGM.playing:
		Global.PodiumBGM.stop()
		Global.RaceBGM.stop()
		Global.TitleBGM.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$sky.position.x -= 1
	if $sky.position.x <= -2048:
		$sky.position.x = 2048
	
	$sky2.position.x -= 1
	if $sky2.position.x <= -2048:
		$sky2.position.x = 2048


func _on_Start_button_down():
	get_tree().change_scene("res://CatSelect.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://Help.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")
