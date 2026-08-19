extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var audio_stream_player: AudioStreamPlayer = $CanvasLayer/SettingsScreen/ScreenContainer/VolumeContainer/AudioContainer/Button/AudioStreamPlayer

@onready var settings_screen: PanelContainer = $CanvasLayer/SettingsScreen
@onready var credits_screen: PanelContainer = $CanvasLayer/CreditsScreen

@onready var button_credits: Button = $CanvasLayer/NavigationPanel/NavContainer/ButtonCredits
@onready var button_settings: Button = $CanvasLayer/NavigationPanel/NavContainer/ButtonSettings

signal can_unpause
signal return_to_menu
signal quit_game

func _on_menu_button_pressed() -> void:
	Dialogic.paused = false
	make_visible(false)
	emit_signal('can_unpause')

func _on_settings_pressed() -> void:
	credits_screen.hide()
	button_credits.disabled = false
	settings_screen.show()
	button_settings.disabled = true

func _on_credits_pressed() -> void:
	credits_screen.show()
	button_credits.disabled = true
	settings_screen.hide() 
	button_settings.disabled = false

func _on_return_to_menu() -> void:
	emit_signal('return_to_menu')
	
func _on_quit_game() -> void:
	emit_signal('quit_game')

func _on_sound_value_changed(value:float) -> void:
	var bus_index = AudioServer.get_bus_index("Audio")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_music_value_changed(value:float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_test_sound_button_pressed() -> void:
	audio_stream_player.play()

@warning_ignore("shadowed_variable_base_class")
func make_visible(visible:bool) -> void:
	if visible:
		self.show()
	else:
		self.hide()
	
	canvas_layer.visible = visible
