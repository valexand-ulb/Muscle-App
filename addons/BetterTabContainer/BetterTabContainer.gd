## Scrollable tabs, based on the ScrollContainer
##
## to get started, add BetterTabContainer node to your scene,
## set it's size to full rect or hwide and add a few nodes to it
## please ignore the "multiple nodes" warning. Each node inside
## is treated as a separate tab. You might also want to hide
## the horizontal scroll bar at the bottom, as it does nothing

extends ScrollContainer

signal tab_switched(tab)

onready var tabs_holder := MarginContainer.new()
onready var children    := get_children()
onready var sizex       := rect_size.x

export(int)   var current_tab = 0
export(float) var swipe_threshold = 128.0
export(bool)  var smooth_switch = true
export(float) var switch_power = 5.0

var scroll_velocity := Vector2.ZERO
var scrolling       := false
var target_scroll   := 0.0
var current_scroll  := 0.0
var prev_on_tab     := false
var drag_init_pos   := Vector2.ZERO
var swipe_threshold_reached := false
var scrolled_with_wheel := false

func _ready() -> void:
	# add a tab holder to the container and move all the children to it
	add_child(tabs_holder)
	for child in children:
		if(child is ScrollBar): continue
		remove_child(child)
		tabs_holder.add_child(child)
		child.mouse_filter = Control.MOUSE_FILTER_PASS
	children = tabs_holder.get_children()
		
	# adjust all the properties of the containers
	scroll_vertical_enabled = false
	scroll_horizontal_enabled = true
	tabs_holder.size_flags_vertical = 3
	tabs_holder.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# connect required signals
	get_tree().get_root().connect("size_changed", self, "resize")
	tabs_holder.connect("sort_children", self, "resize")
	connect("gui_input", self, "_manage_input")
	resize()
	switch_tab()
	update_target_scroll(true)
	
func _process(delta: float) -> void:
	if scrolling:
		current_scroll = scroll_horizontal
	else:
		# smoothly scroll to the current tab
		if prev_on_tab or scrolled_with_wheel: current_scroll = target_scroll
		else: current_scroll += (target_scroll - scroll_horizontal) * 8.0 * delta
		scroll_horizontal = current_scroll
		
	# prevent actual mouse wheel scrolling
	prev_on_tab = abs(current_scroll - target_scroll) < 1
	
func resize() -> void:
	# handle window resizing
	sizex = rect_size.x
	tabs_holder.rect_min_size.x = sizex * children.size()	
	
	var childi := 0
	for child in children:
		child.rect_size.x = sizex
		child.rect_position.x = sizex * childi
		childi += 1
		
	update_target_scroll(true)
	
func _manage_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# when the drag is stopped, end scrolling
		if event.button_index in [BUTTON_WHEEL_UP, BUTTON_WHEEL_DOWN, BUTTON_WHEEL_LEFT, BUTTON_WHEEL_RIGHT]:
			scrolled_with_wheel = true
			
	elif event is InputEventScreenDrag:
		scroll_velocity = event.relative
		
		# check for swipe threshold
		if not swipe_threshold_reached:
			#scroll_horizontal = target_scroll
			var diff = abs(drag_init_pos.x - event.position.x)
			if diff > swipe_threshold: 
				swipe_threshold_reached = true
			else:
				scroll_horizontal = target_scroll
		else:
			# fake scroll, because for some reason, real scrolling stops
			current_scroll -= event.relative.x
			scroll_horizontal = current_scroll
				
	elif event is InputEventScreenTouch:
		if event.is_pressed():
			scrolling = true
			drag_init_pos = event.position
			swipe_threshold_reached = false
			scrolled_with_wheel = false
		else:
			end_scroll()
		
func end_scroll() -> void:
	# calculate current tab, based on the horizontal scroll and the drag velocity 
	# and then switch to it
	current_tab = int(clamp(round((scroll_horizontal - min(scroll_velocity.x * switch_power, sizex)) / sizex), 0, children.size()-1))
	switch_tab()
	scroll_velocity = Vector2.ZERO
	scrolling = false
	
func update_target_scroll(instant:bool=false) -> void:
	# calculate horizontal scrolling required to fully switch to a single tab, with no overlaps
	# if instant is true, also update the current scroll
	target_scroll = current_tab * sizex
	if instant: 
		current_scroll = target_scroll
		scroll_horizontal = current_scroll
	else:
		prev_on_tab = false
	
func switch_tab(tab:int=-1) -> void:
	if tab >= 0: 
		current_tab = tab
		scrolled_with_wheel = false
	update_target_scroll(!smooth_switch)
	emit_signal("tab_switched", current_tab)
