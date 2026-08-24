extends TextureButton

@onready var btn_line_boiler   : AnimationPlayer = $"../BtnLineBoiler"
@onready var date_profile_view : Control         = $"../../DateProfileView"
@onready var button_app_logo   : TextureButton   = $"../../UI Features/Button_AppLogo"
@onready var scroll_container: ScrollContainer = $"../../DateProfileView/ScrollContainer"

const ADA_INTENSITY = preload("uid://bnok7unit45av")

var btn_tween : Tween

func _on_btn_ada_entered() -> void:
	if (self.disabled):
		return
	
	reset_btn_tween()
	scroll_container.get_v_scroll_bar().value = scroll_container.get_v_scroll_bar().min_value
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.94, 0.94), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(0, false)
	
func _on_btn_ada_pressed() -> void:
	if (self.disabled):
		return
	
	self.get_parent().hide()
	date_profile_view.set_profile("lineboil_ada")
	date_profile_view.set_text(CharacterLibrary.ada.char_name + ", " + CharacterLibrary.ada.age,
							   CharacterLibrary.ada.job,
							   CharacterLibrary.ada.bio)
	date_profile_view.texture_intensity.texture = ADA_INTENSITY
	date_profile_view.show()
	button_app_logo.modulate = Color("636363")
	button_app_logo.disabled = true
	

func _on_btn_ada_exited() -> void:
	if (self.disabled):
		return
	
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.89, 0.89), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(0, true)
	
func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
