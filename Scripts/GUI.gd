extends Control


func _disable_scrollbar():
	$MainScrollBox.get_h_scrollbar().rect_scale.x = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_disable_scrollbar()
	
func _on_New_pressed():
	var CardScene = load("res://Scenes/Card.tscn")
	var _Card_instance = CardScene.instance()
	
	$MainScrollBox/HBoxContainer/ColorRectWhite/HBoxContainer/ScrollContainer/VBoxContainer.add_child(_Card_instance)
