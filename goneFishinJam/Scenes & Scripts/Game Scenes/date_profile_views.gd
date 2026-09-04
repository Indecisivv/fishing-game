extends Control

@onready var label_name : Label = $VBoxContainer/Label_Name
@onready var label_job  : Label = $VBoxContainer/HBoxContainer/Label_Job
@onready var label_bio  : Label = $ScrollContainer/Label_Bio
@onready var texture_intensity: TextureRect = $VBoxContainer/HBoxContainer/HBoxContainer/Texture_Intensity

@onready var animation_player : AnimationPlayer   = $AnimationPlayer
@onready var button_heart     : TextureButton     = $Button_Heart
@onready var button_back      : TextureButton     = $Button_Back
@onready var match_sound      : AudioStreamPlayer = $Button_Heart/MatchSound
@onready var match_screen     : Control           = $"../MatchScreen"

var btn_tween         : Tween
var current_animation : String

func _on_button_heart_entered() -> void:
	set_tween(button_heart, Vector2(1.1, 1.1))
	animation_player.get_animation(current_animation).track_set_enabled(1, false)
	
func _on_button_heart_pressed() -> void:
	match current_animation:
		"lineboil_ada":
			self.hide()
			match_screen.set_icon("ada_icon")
			match_screen.show()
		"lineboil_soccoro":
			self.hide()
			match_screen.set_icon("socorro_icon")
			match_screen.show()
		"lineboil_khanh":
			self.hide()
			match_screen.set_icon("khanh_icon")
			match_screen.show()
	match_sound.play()

# who up tweening it and by it i mean haha my fucking buttons hahahaha
func _on_button_heart_exited() -> void:
	set_tween(button_heart, Vector2.ONE)
	animation_player.get_animation(current_animation).track_set_enabled(1, true)

func _on_button_back_entered() -> void:
	set_tween(button_back, Vector2(1.1, 1.1))
	animation_player.get_animation(current_animation).track_set_enabled(0, false)

func _on_button_back_exited() -> void:
	set_tween(button_back, Vector2.ONE)
	animation_player.get_animation(current_animation).track_set_enabled(0, true)

func set_profile(animation:String) -> void:
	current_animation = animation
	animation_player.play(animation)

func set_text(profile_name:String, job:String, text:String) -> void:
	label_name.text = profile_name
	label_job.text  = job
	label_bio.text = text

var current_char_data: CharacterClass = null

func update_profile_text() -> void:
	if current_char_data == null: return
	
	# Dynamically translate the pronouns and bio when this runs
	set_text(
		current_char_data.char_name + ", " + current_char_data.age,
		tr(current_char_data.job), 
		tr(current_char_data.bio)
	)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		# If the profile screen is open, automatically refresh the text!
		if is_visible_in_tree():
			update_profile_text()
					
func set_tween(object:Object, final_val:Vector2) -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(object, "scale", final_val, 0.4)

func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
