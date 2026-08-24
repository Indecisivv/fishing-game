extends TextureButton

@onready var click_sound: AudioStreamPlayer = $"../Button Sounds/ClickSound"
@onready var hover_sound: AudioStreamPlayer = $"../Button Sounds/HoverSound"
@onready var play_sound: AudioStreamPlayer = $"../Button Sounds/PlaySound"

var tween: Tween
var can_press : bool = true

func _on_mouse_entered() -> void:
	hover_sound.play()
	
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)

func _on_mouse_exited() -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)

func _on_play_pressed() -> void:
	if !can_press:
		return
	
	can_press = false
	
	play_sound.play()
	
	# Only play the sound after 5 seconds
	await get_tree().create_timer(5).timeout
	can_press = true

func _on_pressed() -> void:
	click_sound.play()

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
