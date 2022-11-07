extends Control

onready var tab_container = $TabContainer

func _ready():
	$MarginContainer/HBoxContainer/Create.disabled = 1


func _enable_other_button(idx : int):
	var button_names = ["Create", "Timing", "Trainings", "Graph"]
	for i in range(4):
		if i != idx :
			get_node("MarginContainer/HBoxContainer/" + button_names[i]).disabled = 0

func _on_Create_button_up():
	tab_container.current_tab = 0
	$MarginContainer/HBoxContainer/Create.disabled = 1
	_enable_other_button(0)


func _on_Timing_button_up():
	tab_container.current_tab = 1
	$MarginContainer/HBoxContainer/Timing.disabled = 1
	_enable_other_button(1)


func _on_Trainings_button_up():
	tab_container.current_tab = 2
	$MarginContainer/HBoxContainer/Trainings.disabled = 1
	_enable_other_button(2)


func _on_Graph_button_up():
	tab_container.current_tab = 3
	$MarginContainer/HBoxContainer/Graph.disabled = 1
	_enable_other_button(3)
