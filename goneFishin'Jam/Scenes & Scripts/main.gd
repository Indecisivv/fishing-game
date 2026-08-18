extends Node2D

## This script acts as a listener and handles all the scene transitions.

# These properties are all references to the different scenes and are assigned on ready.
@onready var scn_main_menu       : Control = $"Scenes/Main Menu"
@onready var scn_settings        : Control = $"Scenes/Settings"
@onready var scn_credits         : Control = $"Scenes/Credits"
@onready var scn_gallery         : Control = $"Scenes/Gallery"
@onready var scn_people_near_you : Control = $"Gameplay Scenes/PeopleNearYou"
@onready var scn_texting_stage   : Control = $"Gameplay Scenes/TextingStage"
@onready var scn_date_time       : Control = $"Gameplay Scenes/DateTime"
@onready var scn_date_end        : Control = $"Gameplay Scenes/DateEnd"
@onready var scn_game_end        : Control = $"Gameplay Scenes/GameEndScreen"

# The total number of dateable characters in the game. Assigned from the editor. 3 by default.
@export var num_total_chars : int

# This property is to specify which timeline will be loaded.
var timeline_uid : String

# These properties are used to decide which ending CG the player gets.
var wins            : Array[bool]
var win_counter     : int = 0
var all_chars_dated : bool

# These properties are used for this script to distinguish who the character is dating.
var on_date_ada     : bool
var on_date_soccoro : bool
var on_date_khanh   : bool

# We declare the size of the wins array and connect our method to Dialogic signal.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	wins.resize(num_total_chars)

func _on_gallery_entered() -> void:
	scn_main_menu.hide()
	scn_gallery.show()

func _on_settings_entered() -> void:
	scn_settings.show()

func _on_credits_entered() -> void:
	scn_main_menu.hide()
	scn_credits.show()

# This method transitions from the main menu to the dating app.
func _on_game_started() -> void:
	FadeToBlackTransition.fade_to_black()
	await FadeToBlackTransition.transition_finished
	scn_main_menu.hide()
	scn_people_near_you.show()
	scn_people_near_you.enter_phone()

# This method transitions from the dating app to the date. It loads a different timeline depending
# on which character the player picks.
func _on_date_selected() -> void:
	match scn_people_near_you.index:
		0: # Ada Date
			timeline_uid = "uid://cbw025irc4err"
			
			on_date_ada = true
			on_date_soccoro = false
			on_date_khanh = false
		1: # Soccoro Date
			timeline_uid = "uid://ch3bft3so2h5m"
			
			on_date_ada = false
			on_date_soccoro = true
			on_date_khanh = false
		2: # Khanh Date
			timeline_uid = "uid://d0fcwuv1yrdw"
			
			on_date_ada = false
			on_date_soccoro = false
			on_date_khanh = true
		
	scn_people_near_you.hide()
	scn_date_end.hide()
	scn_texting_stage.load_timeline(timeline_uid)

# This method transitions from the date to the date end screen.
func _on_dialogic_signal(argument:String) -> void:
	if argument == "scene_end":
		scn_people_near_you.disable_button()
		show_scn_date_end()

# This method takes the user back to the main menu.
func _on_return_to_main_menu() -> void:
	scn_gallery.hide()
	scn_settings.hide()
	scn_credits.hide()
	scn_people_near_you.hide()
	scn_people_near_you.reset_phone()
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
	if on_date_ada && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_1)
		scn_date_end.set_text('Date success!')
	elif on_date_ada && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_1)
		scn_date_end.set_text('Date failure...')
	
	if on_date_soccoro && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_2)
		scn_date_end.set_text('Date success!')
	elif on_date_soccoro && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_2)
		scn_date_end.set_text('Date failure...')
	
	if on_date_khanh && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_3)
		scn_date_end.set_text('Date success!')
	elif on_date_khanh && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(scn_date_end.BG_DINNER_3)
		scn_date_end.set_text('Date failure...')
	
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
	scn_texting_stage.hide()
	scn_date_end.hide()
	scn_game_end.hide()
	
	win_counter = 0
	all_chars_dated = false
	for i in wins.size():
		wins[i] = false
	
	scn_people_near_you.reset_all_buttons()
	
