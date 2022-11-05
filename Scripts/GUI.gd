extends Control


func _disable_scrollbars():
	#$Test/Panel1/ScrollContainer.get_h_scrollbar().rect_scale.x = 0
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	_disable_scrollbars()
