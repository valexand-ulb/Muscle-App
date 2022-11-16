extends Control

# tabs & tab_container
onready var tab_container = get_node("TabContainer")
onready var create_tab = get_node("MarginContainer/HBoxContainer/Create")
onready var timing_tab = get_node("MarginContainer/HBoxContainer/Timing")
onready var trainings_tab = get_node("MarginContainer/HBoxContainer/Trainings")
onready var graph_tab = get_node("MarginContainer/HBoxContainer/Graph")

# buttons save & delete
onready var delete_button = get_node("TabContainer/Create/ButtonBox/Delete")
onready var save_button = get_node("TabContainer/Create/ButtonBox/Save")

# popup
onready var popup_window = get_node("TabContainer/Create/PopUpSave")

func _ready():
	# bouton initials appuyé
	create_tab.disabled = 1
	
	# boutons invisibles
	delete_button.visible = 0
	save_button.visible = 0
	
	# connect vbox to popup
	popup_window.vbox_node = get_node("TabContainer/Create/ScrollContainer/VBoxContainer")

func _enable_other_button(idx : int):
	var button_names = ["Create", "Timing", "Trainings", "Graph"]
	for i in range(4):
		if i != idx :
			get_node("MarginContainer/HBoxContainer/" + button_names[i]).disabled = 0

func _on_Create_button_up():
	tab_container.current_tab = 0
	create_tab.disabled = 1
	_enable_other_button(0)


func _on_Timing_button_up():
	tab_container.current_tab = 1
	timing_tab.disabled = 1
	_enable_other_button(1)


func _on_Trainings_button_up():
	tab_container.current_tab = 2
	trainings_tab.disabled = 1
	_enable_other_button(2)


func _on_Graph_button_up():
	tab_container.current_tab = 3
	graph_tab.disabled = 1
	_enable_other_button(3)
