extends Control


func _disable_scrollbars():
	$MainScrollBox.get_h_scrollbar().rect_scale.x = 0
	$MainScrollBox/HBoxContainer/Panel1/ScrollContainer.get_h_scrollbar().rect_scale.x = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_disable_scrollbars()
