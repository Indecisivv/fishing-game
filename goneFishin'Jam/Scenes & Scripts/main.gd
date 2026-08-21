extends Node2D

## This script acts as a listener and handles all the scene transitions.

# if ren_flowery_stim || perry_flowery_stim || penny_flowery_stim || mew_flowery_stim:
# 	nuke_entire_codebase()

# These properties are all references to the different scenes and are assigned on ready
@onready var scn_people_near_you : Control = $"Gameplay Scenes/PeopleNearYou"
@onready var scn_texting_stage   : Control = $"Gameplay Scenes/TextingStage"
@onready var scn_date_time       : Control = $"Gameplay Scenes/DateTime"
@onready var scn_date_end        : Control = $"Gameplay Scenes/DateEnd"
@onready var scn_game_end        : Control = $"Gameplay Scenes/GameEndScreen"
@onready var scn_main_menu       : Control = $"Scenes/Main Menu"
@onready var scn_settings        : Control = $Scenes/Settings
@onready var scn_quit_confirm    : Control = $"Pop-Ups/QuitConfirm"

# The total number of dateable characters in the game. Assigned from the editor. 3 by default.
@export var num_total_chars : int

# This property is to specify which timeline will be loaded.
var timeline_uid : String

# These properties are used to decide which ending CG the player gets.
var wins            : Array[bool]
var win_counter     : int = 0
var num_online      : int
var all_chars_dated : bool

# These properties are used for this script to distinguish who the character is dating.
var on_date_ada     : bool
var on_date_soccoro : bool
var on_date_khanh   : bool

# These signals are sent back to one of the scenes under this node for navigation.
signal can_unpause
signal credits_entered
signal settings_entered

# We declare the size of the wins array and connect our method to Dialogic signal.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	wins.resize(num_total_chars)
	num_online = num_total_chars + 1
	print("On Start, Win Counter: " + str(win_counter))

func _on_settings_entered() -> void:
	emit_signal('settings_entered')
	scn_settings.make_visible(true)
	Dialogic.paused = true

func _on_texting_stage_can_unpause() -> void:
	emit_signal('can_unpause')

func _on_credits_entered() -> void:
	emit_signal('credits_entered')
	scn_settings.make_visible(true)

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
			timeline_uid = "uid://c15x2a653il05"
			
			on_date_ada = true
			on_date_soccoro = false
			on_date_khanh = false
			
			scn_texting_stage.set_contact("Ada Pugita", "ada_icon")
		1: # Khanh Date
			timeline_uid = "uid://bqy2bj8j45shb"
			
			on_date_ada = false
			on_date_soccoro = false
			on_date_khanh = true
			
			scn_texting_stage.set_contact("Khanh Cá Trê", "khanh_icon")
		2: # Socorro Date
			timeline_uid = "uid://c27dtd0mrhwf"
			
			on_date_ada = false
			on_date_soccoro = true
			on_date_khanh = false
			
			scn_texting_stage.set_contact("Socorro Tiburon", "socorro_icon")
		
	scn_people_near_you.hide()
	scn_date_end.hide()
	scn_texting_stage.show()
	scn_texting_stage.load_timeline(timeline_uid)

# This method transitions from the date to the date end screen.
func _on_dialogic_signal(argument:String) -> void:
	if argument == "scene_end":
		Dialogic.end_timeline(true)
	
		if Dialogic.Styles.get_layout_node():
			Dialogic.Styles.get_layout_node().queue_free()
		
		num_online -= 1
		scn_people_near_you.set_people_online(num_online)
		scn_people_near_you.disable_button()
		scn_people_near_you.reset_loading_screen()
		scn_texting_stage.hide()
		
		scn_date_time.show_button(false)
		scn_date_time.hide()
		
		show_scn_date_end()
		
		print("On Scene End, Win Counter: " + str(win_counter))
	
	if argument == "date_start":
		scn_texting_stage.hide()
		scn_date_time.show_button(true)
		scn_date_time.show()

# This method takes the user back to the main menu.
func _on_return_to_main_menu() -> void:
	if Dialogic.current_timeline:
		Dialogic.current_timeline.clean()
	
	Dialogic.end_timeline(true)
	
	if Dialogic.Styles.get_layout_node():
		Dialogic.Styles.get_layout_node().queue_free()
	Dialogic.paused = false
	
	FadeToBlackTransition.fade_to_black()
	await FadeToBlackTransition.transition_finished
	
	scn_texting_stage.hide()
	scn_settings.make_visible(false)
	scn_people_near_you.hide()
	scn_people_near_you.reset_phone()
	scn_people_near_you.reset_loading_screen()
	scn_date_time.hide()
	scn_date_time.show_button(false)
	scn_date_end.hide()
	scn_game_end.hide()
	
	if (all_chars_dated):
		show_ending()
	else:
		scn_main_menu.show()

func _on_return_to_phone_screen() -> void:
	if (all_chars_dated):
		_on_return_to_main_menu()
		return
	
	FadeToBlackTransition.fade_to_black()
	await FadeToBlackTransition.transition_finished
	scn_date_end.hide()
	scn_people_near_you.show()
	scn_people_near_you.reset_screen()

# This method sets the all_chars_dated bool to true so the code knows to show the ending CG when the
# user returns to the menu.
func _on_all_chars_dated() -> void:
	all_chars_dated = true

# Signal method for restarting the game after receiving the ending.
func _on_game_restart() -> void:
	restart_game()

func _on_quit_btn_pressed() -> void:
	scn_quit_confirm.make_visible(true)
	scn_quit_confirm.set_text(true)

func _on_return_to_menu_btn_pressed() -> void:
	scn_quit_confirm.make_visible(true)
	scn_quit_confirm.set_text(false)

func _on_game_close() -> void:
	get_tree().quit()

# Method that shows the results of a date after it ends.
func show_scn_date_end() -> void:
	if on_date_ada && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(true, "ada")
		scn_date_end.play_music()
	elif on_date_ada && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(false)
		scn_date_end.set_lose_text(CharacterLibrary.ada.char_name + " has snapped 
		the line...")
		scn_date_end.unmatch.play()
	
	if on_date_khanh && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(true, "khanh")
		scn_date_end.play_music()
	elif on_date_khanh && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(false)
		scn_date_end.set_lose_text(CharacterLibrary.khanh.char_name + " has snapped 
		the line...")
		scn_date_end.unmatch.play()
	
	if on_date_soccoro && Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(true, "socorro")
		scn_date_end.play_music()
	elif on_date_soccoro && !Dialogic.VAR.is_date_success:
		scn_date_end.set_cg(false)
		scn_date_end.set_lose_text(CharacterLibrary.soccoro.char_name + " has snapped 
		the line...")
		scn_date_end.unmatch.play()
	
	scn_date_end.show()

# This method presents the player with the corresponding ending depending on how many characters they
# successfully wooed.
func show_ending() -> void:
	wins[0] = Dialogic.VAR.is_fdate_success
	wins[1] = Dialogic.VAR.is_sdate_success
	wins[2] = Dialogic.VAR.is_tdate_success
	
	for i in wins.size():
		if wins[i]:
			print(str(wins[i]) + ", Win Counter: " + str(win_counter))
			win_counter += 1
	
	if win_counter >= num_total_chars:
		scn_game_end.set_end_label(3)
		scn_game_end.set_end_text(3)
		scn_game_end.set_cg("all_caught")
	elif win_counter == 2:
		scn_game_end.set_end_label(2)
		scn_game_end.set_end_text(2)
		scn_game_end.set_cg("one_more_bite")
	elif win_counter == 1:
		scn_game_end.set_end_label(1)
		scn_game_end.set_end_text(1)
		scn_game_end.set_cg("one_caught")
	elif win_counter == 0:
		scn_game_end.set_end_label(0)
		scn_game_end.set_end_text(0)
		scn_game_end.set_cg("no_pull")
		
	scn_game_end.play_music()
	scn_game_end.show()

# Resets all variables and scenes in the game
func restart_game() -> void:
	FadeToBlackTransition.fade_to_black()
	await FadeToBlackTransition.transition_finished
	
	scn_main_menu.show()
	scn_people_near_you.hide()
	scn_texting_stage.hide()
	scn_date_time.hide()
	scn_date_time.show_button(false)
	scn_date_end.hide()
	scn_game_end.hide()
	
	num_online = num_total_chars
	scn_people_near_you.set_people_online(num_online)
	win_counter = 0
	all_chars_dated = false
	for i in wins.size():
		wins[i] = false
	
	scn_people_near_you.reset_all_buttons()
