extends TextureButton

@onready var phone_line_boiler: AnimationPlayer = $"../../PhoneLineBoiler"
@onready var date_profile_view: Control = $"../../DateProfileView"
@onready var date_choices_view: Control = $"../../DateChoicesView"
@onready var button_heart: TextureButton = $"../../DateProfileView/Button_Heart"

var btn_tween : Tween
var can_press : bool = false

# Handles line boil and tweening
func _on_btn_entered() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(1, false)
	pass

func _on_btn_pressed() -> void:
	if !can_press:
		return
	
	button_heart.modulate = Color("636363")
	date_choices_view.hide()
	date_profile_view.set_profile("lineboil_mc")
	date_profile_view.set_text("Chud MC" + ", " + "Age of a Chud",
							   "CHUD THAT EATS PEOPLE",
							   "I EAT BADDIES NEVER LET ME SPREAD MY GENE POOL")
	date_profile_view.show()

func _on_btn_exited() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1, 1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(1, true)
	pass
	
func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
