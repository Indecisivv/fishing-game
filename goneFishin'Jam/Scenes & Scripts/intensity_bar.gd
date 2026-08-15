extends CanvasLayer

@export var progress_bars : Array[ProgressBar] # This contains references to the progress bar nodes.
@export var fill_speed : int 				   # This decides how fast the progress bars fill up.

# These fields are for handling the progress bars.
var index : int = 0
var direction : int = 1

# I call the methods in _physics_process() to avoid any calculation bugs. Not sure if it does anything,
# but I figure it's good practice.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("dialogic_default_action"):
		update_progress_bars(delta)
	if Input.is_action_just_released("dialogic_default_action"):
		reset_progress_bars()

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
