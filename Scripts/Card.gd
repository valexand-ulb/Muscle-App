extends Control
 
var weight : int = 30
var exercices = ["Exercice 1","Exercice 2","Exercice 3","Exercice 4"]
var y_size : int  = get_rect().size.y

onready var exercice_dropbox = get_node("MainBox/Exercice")
onready var rep_line_edit = get_node("MainBox/GridContainer/LineEditR")
onready var option_button_weight = get_node("MainBox/GridContainer/OptionButtonW")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_exercice():
	return exercice_dropbox.get_item_text(exercice_dropbox.get_selected_id())

func get_rep():
	return rep_line_edit.get_line_edit().get_text()
	
func get_weight():
	return option_button_weight.get_item_text(option_button_weight.get_selected_id())

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
