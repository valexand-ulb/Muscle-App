extends Control
 
var weight : int = 60

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _add_dropdown_items():
	for i in range(4, weight+2, 2):
		$MainBox/GridContainer/OptionButtonW.add_item(str(i) + " Kg")
		

func _on_Card_child_entered_tree(_node):
	# initialise les dropdown buttons
	_add_dropdown_items()
	
