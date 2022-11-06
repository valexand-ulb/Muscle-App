extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_pressed():
	var CardScene = load("res://Scenes/Card.tscn")
	var _Card_instance = CardScene.instance()
	add_child(_Card_instance)
	#$".."
