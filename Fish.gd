extends Area2D

signal fish_spawn(target)
signal fish_eaten(target, eater)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn():
	emit_signal("fish_spawn", self)
	$AnimatedSprite.play("flop")

func _on_Fish_area_entered(area):
	if area.name.match("**Cat****"):
		emit_signal("fish_eaten", self, area)
		queue_free()


func _on_Fish_body_entered(body):
	if body.name.match("**Cat****"):
		emit_signal("fish_eaten", self, body)
		queue_free()
