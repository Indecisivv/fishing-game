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
var wins         : Array[bool]
var win_counter  : int = 0

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
		scn_date_end.show() # TO-DO: Make the DateEnd scene display the appropriate text depending
							# on whether or not the date was a success.

# This method takes the user back to the main menu either from the date end screen or the game
# end screen.
func _on_return_to_main_menu() -> void:
	scn_date_end.hide()
	scn_game_end.hide()
	scn_main_menu.show()

# This method presents the player with the corresponding ending depending on how many characters they
# successfully wooed.
# TO-DO:
# 	- Add a button for returning to the main menu
# 	- Ensure that this screen is shown instead of date end if, upon the end of a timeline, all characters
#     have been dated.
func _on_all_chars_dated() -> void:
	wins[0] = Dialogic.VAR.is_fdate_success
	wins[1] = Dialogic.VAR.is_sdate_success
	wins[2] = Dialogic.VAR.is_tdate_success
	
	for i in wins.size():
		print(wins[i])
		if wins[i]:
			win_counter += 1
			print(win_counter)
	
	if win_counter >= num_total_chars:
		scn_game_end.set_end_text("You pulled everyone. Congrats!")
	elif win_counter > 0 && win_counter < num_total_chars:
		scn_game_end.set_end_text("You pulled not everyone but not no one...")
	else:
		scn_game_end.set_end_text("YOU FUMBLED EVERYONE")
	
	scn_game_end.show()
