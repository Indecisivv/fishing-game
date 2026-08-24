extends TextureButton
@onready var hover_sound: AudioStreamPlayer = $"../Button Sounds/HoverSound"

func _on_mouse_entered() -> void:
	hover_sound.play()
		
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.45, 0.45), 0.1)


func _on_pressed() -> void:
	OS.shell_open("https://indecisiv.itch.io/")
