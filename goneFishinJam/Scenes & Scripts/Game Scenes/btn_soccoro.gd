extends TextureButton

@onready var btn_line_boiler   : AnimationPlayer = $"../BtnLineBoiler"
@onready var date_profile_view : Control         = $"../../DateProfileView"
@onready var button_app_logo   : TextureButton   = $"../../UI Features/Button_AppLogo"
@onready var scroll_container: ScrollContainer = $"../../DateProfileView/ScrollContainer"

const SOCORRO_INTENSITY = preload("uid://dcjge0yxmdy26")

var btn_tween : Tween

func _on_btn_soccoro_entered() -> void:
	if (self.disabled):
		return
		
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.94, 0.94), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(2, false)
		
func _on_btn_soccoro_pressed() -> void:
	if (self.disabled):
		return
	
	self.get_parent().hide()
	scroll_container.get_v_scroll_bar().value = scroll_container.get_v_scroll_bar().min_value

	date_profile_view.set_profile("lineboil_soccoro")
	
	date_profile_view.current_char_data = CharacterLibrary.soccoro
	
	date_profile_view.update_profile_text()
	#date_profile_view.set_text(CharacterLibrary.soccoro.char_name + ", " + CharacterLibrary.soccoro.age,
	#						   tr("CHAR_SOCORRO_PRONOUNS"),
	#						   tr("CHAR_SOCORRO_DESC"))
	date_profile_view.show()
	date_profile_view.texture_intensity.texture = SOCORRO_INTENSITY
	button_app_logo.modulate = Color("636363")
	button_app_logo.disabled = true

func _on_btn_soccoro_exited() -> void:
	if (self.disabled):
		return
		
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.89, 0.89), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(2, true)
	
func reset_btn_tween() -> void:
	if (self.disabled):
		return
		
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
