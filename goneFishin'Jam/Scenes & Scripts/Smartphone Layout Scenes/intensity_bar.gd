extends Control

@export var progress_bars : Array[ProgressBar] # This contains references to the progress bar nodes.
@export var fill_speed    : int 			   # This decides how fast the progress bars fill up.

# These fields are for handling the progress bars.
var index     : int = -1
var direction : int = 1
var tween     : Tween

# I call the methods in _physics_process() to avoid any calculation bugs. Not sure if it does anything,
# but I figure it's good practice.
func _physics_process(delta: float) -> void:
	select_dialogue_choice(delta)

# This makes the progress bars either go upwards or downwards. It takes in delta so the fill speed
# remains consistent regardless of framerate.
func update_progress_bars(delta:float) -> void:
	# This checks whether the function has iterated to the end (index 2) or the beginning (index 0)
	# of the array, and sets the direction accordingly. It also sets the index to 2 and 0 to avoid
	# indexing errors.
	if index >= 3:
		index = 2
		direction = -1
	elif index < 0:
		index = 0
		direction = 1
	
	progress_bars[index].value += fill_speed * direction * delta
		
	if direction > 0 && progress_bars[index].value >= progress_bars[index].max_value:
		index += 1
		
	if direction < 0 && progress_bars[index].value <= progress_bars[index].min_value:
		index -= 1
		

# This reset the progress bars and the index
func reset_progress_bars() -> void:
	index = 0
	for i in progress_bars.size():
		progress_bars[i].value = progress_bars[i].min_value

# Focuses on / selects a corresponding dialogue choice depending on the intensity bar's value.
func select_dialogue_choice(delta:float) -> void:
	# Accessing certain properties like VAR and dialogic_default_action can produce errors
	# if they're done before Dialogic's autoloader is ready. This line ensures that it is ready
	# before executing the rest of the method.
	if not Dialogic.is_node_ready():
		await Dialogic.ready
	
	if not Dialogic.VAR.is_making_choice:
		return
	
	# Selects a choice to be focused on based on the index's value
	if Input.is_action_pressed("dialogic_default_action"):
		match index: # This doesn't count as a nested if statement, right, Perry-sensei...?
			0:
				set_button_color(1, Color("50bbb9"))
				set_button_color(2, Color("236463"))
				set_button_color(3, Color("236463"))
				Dialogic.Choices.focus_choice(1)
			1:
				set_button_color(1, Color("236463"))
				set_button_color(2, Color("50bbb9"))
				set_button_color(3, Color("236463"))
				Dialogic.Choices.focus_choice(2)
			2:
				set_button_color(1, Color("236463"))
				set_button_color(2, Color("236463"))
				set_button_color(3, Color("50bbb9"))
				Dialogic.Choices.focus_choice(3)
		
		update_progress_bars(delta)
	
	# Selects a choice to be... selected... based on the index's value
	if Input.is_action_just_released("dialogic_default_action"):
		match index: # This doesn't count as a nested if statement, right, Perry-sensei...?
			0:
				Dialogic.Choices.select_choice(1)
			1:
				Dialogic.Choices.select_choice(2)
			2:
				Dialogic.Choices.select_choice(3)
			
		reset_progress_bars()

func set_button_color(choice_index:int, color:Color) -> void:
	var stylebox : StyleBoxFlat = Dialogic.Choices.get_choice_button(choice_index).get_theme_stylebox("normal").duplicate()
	stylebox.bg_color = color
	Dialogic.Choices.get_choice_button(choice_index).add_theme_stylebox_override("normal", stylebox)
