extends Control
 
var weight : int = 30
var exercices = ["Exercice 1","Exercice 2","Exercice 3","Exercice 4"]
var y_size : int  = get_rect().size.y

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _add_dropdown_items_weight():
	$MainBox/GridContainer/OptionButtonW.add_item("None")
	for i in range(4, weight+2, 2):
		$MainBox/GridContainer/OptionButtonW.add_item(str(i) + " Kg")
		
func _add_dropdown_items_exercices():
	for i in range(len(exercices)):
		$MainBox/Exercice.add_item(exercices[i])
		

func _on_Card_child_entered_tree(_node):
	# initialise les dropdown buttons
	_add_dropdown_items_weight()
	_add_dropdown_items_exercices()
