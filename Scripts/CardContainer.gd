extends VBoxContainer

var save_path = "res://Saves/"
var has_del_button : bool = 0
var has_save_button : bool = 0
var n_of_card  : int = 0

# three buttons
onready var delete_button = get_node("../../ButtonBox/Delete")
onready var save_button = get_node("../../ButtonBox/Save")
onready var new_button = get_node("../../ButtonBox/New")

# popup window
onready var popup_window = get_node("../../PopUpSave")

# scroll container
onready var scroll_container = get_node("..")

# count label
onready var count_label = get_node("../../CountLabel")

func fetch_and_save_all_data(save_name : String):
	var save_dict : Dictionary = {}
	var cards_dict : Dictionary = {}
	var card_name : String = "card_"
	var card_count : int = 0
	
	for card in get_children():
		cards_dict[card_name + str(card_count)] = {
			"ex" : card.get_exercice(),
			"rep": card.get_rep(),
			"weight": card.get_weight()
		}
		card_count += 1

	save_dict[save_name] ={
			"cards": cards_dict
	}

	var file = File.new()

	if file.open(save_path + save_name + ".dat", File.WRITE) == OK:
		file.store_var(save_dict)
		file.close()
	
	_delete_all_children()
	modif_label_count()
	popup_window.visible=0

func _set_buttons_visible():
	delete_button.visible=1
	save_button.visible=1
	has_save_button = 1
	has_del_button = 1

func _set_buttons_invisible():
	delete_button.visible=0
	save_button.visible=0
	has_save_button = 0
	has_del_button = 0

func _delete_all_children():
	for child in get_children():
		child.free()
	_set_buttons_invisible()
	
func modif_label_count():
	# Modification du label
	count_label.text = "Count : " + str(n_of_card)
	
func _on_New_pressed():
	var CardScene = load("res://Scenes/Card.tscn")
	var _Card_instance = CardScene.instance()
	add_child(_Card_instance)
	
	# Si pas de bouton 'delete', ajoute en un
	if not has_del_button:
		_set_buttons_visible()
		
	n_of_card +=1
	modif_label_count()
	
func _on_Delete_pressed():
	var children_list = get_children()
	var current_card : float = ceil((scroll_container.get_v_scroll() + (scroll_container.rect_size.y/2))/scroll_container.rect_size.y) - 1
	if len(children_list) == 1:
		_set_buttons_invisible()
	children_list[current_card].free()
	
	n_of_card -= 1
	modif_label_count()

func _on_Save_pressed():
	popup_window.visible = 1
	#_fetch_and_save_all_data('test')
	
	#_delete_all_children()
	
	n_of_card = 0
	#_modif_label_count()

func _on_ScrollContainer_gui_input(event):
	if not event.is_action_released("ui_touch"):
		return
	
	if !has_del_button:
		return
	
	var current_card : float = ceil((scroll_container.get_v_scroll() + (scroll_container.rect_size.y/2))/scroll_container.rect_size.y) - 1
	
	scroll_container.set_v_scroll(scroll_container.rect_size.y * int(current_card))
