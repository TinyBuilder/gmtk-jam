extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var winner = 0
var second = 1
var third = 2
var rng = RandomNumberGenerator.new()
var front = 0
var player_no = 0
var TitleBGM
var RaceBGM
var PodiumBGM
var lead = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TitleBGM = $TitleBGM
	RaceBGM = $RaceBGM
	PodiumBGM = $PodiumBGM
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
