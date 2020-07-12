extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var page = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("start")
	$LinkButton2.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_LinkButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_LinkButton2_pressed():
	page -= 1
	if page > 1:
		$LinkButton2.disabled = false
	if page < 3:
		$LinkButton3.disabled = false
	if page == 1:
		$LinkButton2.disabled = true
	if page == 3:
		$LinkButton3.disabled = true
		
	for child in $ReferenceRect.get_children():
		child.rect_position.x += 1024


func _on_LinkButton3_pressed():
	page += 1
	if page > 1:
		$LinkButton2.disabled = false
	if page < 3:
		$LinkButton3.disabled = false
	if page == 1:
		$LinkButton2.disabled = true
	if page == 3:
		$LinkButton3.disabled = true
	
	for child in $ReferenceRect.get_children():
		child.rect_position.x -= 1024
