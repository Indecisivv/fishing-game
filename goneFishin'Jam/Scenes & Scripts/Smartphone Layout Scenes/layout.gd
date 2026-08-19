@tool
extends DialogicLayoutBase

# This scene acts as a "style" template for Dialogic. To make it work, make an empty style template in the
# dialogic tab, replace the layer with a custom preset, then select this scene.

# These fields are references to child nodes, and are assigned from the editor.
@export var dialog_text      : DialogicNode_DialogText
@export var scroll_container : ScrollContainer
@export var message_list     : VBoxContainer
@export var timestamp        : Label

const STYLE_BOX_PLAYER = preload("uid://bxp2gyc1o2mbo")
const STYLE_BOX_CHARACTER = preload("uid://c47gvri4qh3vl")

# These fields are where information about dialogue will be stored so it can be displayed separately.
var last_text         := ""
var last_text_size    := Vector2()
var last_text_speaker :  DialogicCharacter = null
var last_text_time    := ""

signal settings_pressed

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)

# The signal method for DialogText's started_revealing_text() signal.
# The text bubble is already configured in the node.
# This method displays sets the size of the chat bubble, its dialogue and timestamp, 
# then sets its position.
func _on_dialog_text_started_revealing_text() -> void:
	dialog_text.show()
	dialog_text.custom_minimum_size = get_message_size(dialog_text.text)
	
	var time := Time.get_datetime_dict_from_system()
	timestamp.text = str(time.hour)+":"+str(time.minute)
	
	# If the one currently speaking is the player, this sets the message on the right side of the screen.
	# Otherwise, the message is set on the left side.
	var speaker : DialogicCharacter = Dialogic.Text.get_current_speaker()
	if speaker.display_name == "Player":
		var stylebox : StyleBoxFlat = dialog_text.get_theme_stylebox("normal").duplicate()
		stylebox.bg_color = Color("50bbb9")
		dialog_text.add_theme_stylebox_override("normal", stylebox)
		dialog_text.size_flags_horizontal = Control.SIZE_SHRINK_END
		timestamp.hide()
	else:
		var stylebox : StyleBoxFlat = dialog_text.get_theme_stylebox("normal").duplicate()
		stylebox.bg_color = Color("b6310c")
		dialog_text.add_theme_stylebox_override("normal", stylebox)
		dialog_text.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		timestamp.show()

# The signal method for DialogText's finished_revealing_text() signal.
# This stores all the information about the current dialogue in the last_text fields,
# then calls the add_message button to display it separately.
func _on_dialog_text_finished_revealing_text() -> void:
	last_text         = dialog_text.text
	last_text_size    = dialog_text.custom_minimum_size
	last_text_speaker = Dialogic.Text.get_current_speaker()
	last_text_time    = timestamp.text
	
	if last_text.is_empty():
		return
	
	dialog_text.hide()
	add_message(last_text, last_text_size, last_text_speaker.get_character_name(), last_text_time)

func _on_settings_entered() -> void:
	emit_signal("settings_pressed")

func _on_timeline_ended() -> void:
	print("Test")
	queue_free()

# This method calculates the minimum size a chat bubble needs to be, given the text it will display.
func get_message_size(text:String) -> Vector2:
	var font: Font = dialog_text.get_theme_font("normal_font", 'RichTextLabel')
	var string_size: Vector2 = font.get_string_size(text, 0 as HorizontalAlignment, -1.0, 10)
	
	var max_width: float = message_list.size.x
	var smallest_line_amount = 1
	for i in range (1, 10):
		if string_size.x/i+20 > max_width:
			continue
		else:
			smallest_line_amount = 1
			break
	
	return Vector2(
		string_size.x / smallest_line_amount + 20,
		string_size.y * smallest_line_amount + 20
	)

# This method adds a new text bubble with the corresponding text, size, time and position.
# The text bubbles added are purely visual, and are separate from DialogText nodes.
func add_message(text:String, size:Vector2, speaker_name:String, time:String) -> void:
	var message: Control = load("res://Scenes & Scripts/Smartphone Layout Scenes/message_panel.tscn").instantiate()
	message_list.add_child(message)
	message_list.move_child(message, -1)
	
	message.text = text
	message.custom_minimum_size = size
	message.set_meta('speaker', name)
	timestamp.text = time
	
	# If the one currently speaking is the player, this sets the message on the right side of the screen.
	# Otherwise, the message is set on the left side.
	if speaker_name == "Player":
		var stylebox : StyleBoxFlat = dialog_text.get_theme_stylebox("normal").duplicate()
		stylebox.bg_color = Color("50bbb9")
		message.add_theme_stylebox_override("normal", stylebox)
		message.size_flags_horizontal = Control.SIZE_SHRINK_END
	else:
		var stylebox : StyleBoxFlat = dialog_text.get_theme_stylebox("normal").duplicate()
		stylebox.bg_color = Color("b6310c")
		message.add_theme_stylebox_override("normal", stylebox)
		message.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		
	await get_tree().process_frame
	
	message_list.get_parent().ensure_control_visible(dialog_text)
	scroll_container.set_deferred("scroll_vertical", scroll_container.get_v_scroll_bar().max_value)
