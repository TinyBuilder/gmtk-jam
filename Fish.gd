extends Area2D

signal fish_spawn
signal fish_eaten

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn():
	emit_signal("fish_spawn")
	print("Fish ready")

func _on_Fish_area_entered(area):
	if area.name == "Cat":
		emit_signal("fish_eaten")
		queue_free()
