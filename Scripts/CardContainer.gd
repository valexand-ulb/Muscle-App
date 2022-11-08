extends VBoxContainer

var has_del_button : bool = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _set_del_button_visible():
	$"../../ButtonBox/Delete".visible=1
	has_del_button = 1

func _set_del_button_invisible():
	$"../../ButtonBox/Delete".visible=0
	has_del_button = 0

func _delete_all_children():
	for child in get_children():
		child.free()
	_set_del_button_invisible()

func _on_New_pressed():
	var CardScene = load("res://Scenes/Card.tscn")
	var _Card_instance = CardScene.instance()
	add_child(_Card_instance)
	
	# Si pas de bouton 'delete', ajoute en un
	if not has_del_button:
		_set_del_button_visible()
		
func _on_Delete_pressed():
	var children_list = get_children()
	if len(children_list) == 1:
		_set_del_button_invisible()
	get_children()[-1].free()


func _on_Save_pressed():
	# TODO : effectue une sauvegarde des informations
	_delete_all_children()
	
