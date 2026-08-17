extends TextureButton

@onready var click_sound: AudioStreamPlayer = $"../Button Sounds/ClickSound"
@onready var hover_sound: AudioStreamPlayer = $"../Button Sounds/HoverSound"

var tween: Tween

func _on_mouse_entered() -> void:
	hover_sound.play()
	
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)

func _on_mouse_exited() -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)

func _on_pressed() -> void:
	click_sound.play()

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
