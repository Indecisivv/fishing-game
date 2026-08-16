extends Node2D

## This script acts as a listener and handles all the scene transitions.

# These properties are all references to the different scenes in the game.
@export var scn_main_menu       : Control
@export var scn_people_near_you : Control
@export var scn_date_time       : Control
@export var scn_date_end        : Control
@export var scn_game_end        : Control
@export var num_total_chars     : int

# This property is to specify which timeline will be loaded.
var timeline_uid : String

# These properties are used to decide which ending CG the player gets.
var wins            : Array[bool]
var win_counter     : int = 0
var all_chars_dated : bool

# We declare the size of the wins array and connect our method to Dialogic signal.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	wins.resize(num_total_chars)

# This method transitions from the main menu to the dating app.
func _on_game_started() -> void:
	scn_main_menu.hide()
	scn_people_near_you.show()

# This method transitions from the dating app to the date. It loads a different timeline depending
# on which character the player picks.
func _on_date_selected() -> void:
	match scn_people_near_you.index:
		0:
			timeline_uid = "uid://cbw025irc4err"
		1:
			timeline_uid = "uid://ch3bft3so2h5m"
		2:
			timeline_uid = "uid://d0fcwuv1yrdw"
			
	scn_people_near_you.hide()
	scn_date_end.hide()
	scn_date_time.load_timeline(timeline_uid)

# This method transitions from the date to the date end screen.
func _on_dialogic_signal(argument:String) -> void:
	if argument == "scene_end":
		scn_people_near_you.disable_button()
		show_scn_date_end()

# This method takes the user back to the main menu either from the date end screen or the game
# end screen.
func _on_return_to_main_menu() -> void:
	scn_date_end.hide()
	scn_game_end.hide()
	
	if (all_chars_dated):
		show_ending()
	else:
		scn_main_menu.show()

# This method sets the all_chars_dated bool to true so the code knows to show the ending CG when the
# user returns to the menu.
func _on_all_chars_dated() -> void:
	all_chars_dated = true

# Signal method for restarting the game after receiving the ending.
func _on_game_restart() -> void:
	restart_game()

# Method that shows the results of a date after it ends.
func show_scn_date_end() -> void:
	if Dialogic.VAR.is_date_success:
		scn_date_end.set_date_text("Date Success!")
	else:
		scn_date_end.set_date_text("Date failure...")
	
	scn_date_end.show()

# This method presents the player with the corresponding ending depending on how many characters they
# successfully wooed.
func show_ending() -> void:
	wins[0] = Dialogic.VAR.is_fdate_success
	wins[1] = Dialogic.VAR.is_sdate_success
	wins[2] = Dialogic.VAR.is_tdate_success
	
	for i in wins.size():
		if wins[i]:
			win_counter += 1
	
	if win_counter >= num_total_chars:
		scn_game_end.set_end_text("You pulled everyone. Congrats!")
	elif win_counter > 0 && win_counter < num_total_chars:
		scn_game_end.set_end_text("You pulled not everyone but not no one...")
	else:
		scn_game_end.set_end_text("YOU FUMBLED EVERYONE")
	
	scn_game_end.show()

# Resets all variables and scenes in the game
func restart_game() -> void:
	scn_main_menu.show()
	scn_people_near_you.hide()
	scn_date_time.hide()
	scn_date_end.hide()
	scn_game_end.hide()
	
	win_counter = 0
	all_chars_dated = false
	for i in wins.size():
		wins[i] = false
	
	scn_people_near_you.reset_all_buttons()
	
