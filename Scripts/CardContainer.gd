extends VBoxContainer

var has_del_button : bool = 0
var has_save_button : bool = 0
var n_of_card  : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_buttons_visible():
	$"../../ButtonBox/Delete".visible=1
	$"../../ButtonBox/Save".visible=1
	has_save_button = 1
	has_del_button = 1

func _set_buttons_invisible():
	$"../../ButtonBox/Delete".visible=0
	$"../../ButtonBox/Save".visible=0
	has_save_button = 0
	has_del_button = 0

func _delete_all_children():
	for child in get_children():
		child.free()
	_set_buttons_invisible()
	
func _modif_label_count():
	# Modification du label
	$"../../CountLabel".text = "Count : " + str(n_of_card)

func _modif_label_id(card_id : int):
	$"../../IdLabel".text = "Id : " + str(card_id)
	
func _on_New_pressed():
	var CardScene = load("res://Scenes/Card.tscn")
	var _Card_instance = CardScene.instance()
	add_child(_Card_instance)
	
	# Si pas de bouton 'delete', ajoute en un
	if not has_del_button:
		_set_buttons_visible()
		
	n_of_card +=1
	_modif_label_count()
	
func _on_Delete_pressed():
	var scrollcont = $".."
	var children_list = get_children()
	var current_card : float = ceil((scrollcont.get_v_scroll() + (scrollcont.rect_size.y/2))/scrollcont.rect_size.y) - 1
	if len(children_list) == 1:
		_set_buttons_invisible()
	children_list[current_card].free()
	
	n_of_card -= 1
	_modif_label_count()

func _on_Save_pressed():
	# TODO : effectue une sauvegarde des informations
	_delete_all_children()
	
	n_of_card = 0
	_modif_label_count()

func _on_ScrollContainer_gui_input(event):
	if not event.is_action_released("ui_touch"):
		return
	
	if !has_del_button:
		return
	
	var scrollcont = $".."
	var current_card : float = ceil((scrollcont.get_v_scroll() + (scrollcont.rect_size.y/2))/scrollcont.rect_size.y) - 1
	
	scrollcont.set_v_scroll(scrollcont.rect_size.y * int(current_card))
