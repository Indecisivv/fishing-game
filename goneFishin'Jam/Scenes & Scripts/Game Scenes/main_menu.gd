extends Control

@onready var audio_player: AudioStreamPlayer = $MainMenuMusic
var can_press_start : bool = true

func _ready():
	audio_player.volume_db = -20.444
	audio_player.play()

signal game_started
signal settings_entered
signal credits_entered
signal quit_pressed

func _on_start_button_pressed() -> void:
	if !can_press_start:
		return
	
	can_press_start = false
	
	# Create a tween node
	var tween = create_tween()
	# Transition the volume_db property to -80 (silent) over 1.5 seconds
	tween.tween_property(audio_player, "volume_db", -80.0, 1.5)
	# Wait for the tween to finish before changing the scene
	await tween.finished
	audio_player.stop()
	audio_player.volume_db = -20.444
	emit_signal('game_started')
	
	# Start button can only be pressed again after 5 seconds
	await get_tree().create_timer(5).timeout
	can_press_start = true

func _on_settings_button_pressed() -> void:
	emit_signal('settings_entered')

func _on_credits_button_pressed() -> void:
	emit_signal('credits_entered')

func _on_quit_button_pressed() -> void:
	emit_signal('quit_pressed')
