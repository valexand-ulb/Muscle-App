extends WindowDialog

onready var save_button = get_node("MarginContainer/VBoxContainer/Button")
onready var line_edit = get_node("MarginContainer/VBoxContainer/Button")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_close_button().visible = 0
	save_button.disabled = 1

func _on_LineEdit_text_changed(new_text):
	save_button.disabled = 0
	if ! new_text :
		save_button.disabled= 1
