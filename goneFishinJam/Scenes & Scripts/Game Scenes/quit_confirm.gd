extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label: Label = $CanvasLayer/PanelContainer/Label
@onready var button_cancel: Button = $CanvasLayer/PanelContainer/HBoxContainer/ButtonCancel
@onready var button_quit: Button = $CanvasLayer/PanelContainer/HBoxContainer/ButtonQuit

var is_quitting : bool

signal confirm_quit
signal confirm_return_to_menu

func on_quit():
	if is_quitting:
		emit_signal('confirm_quit')
	else:
		emit_signal('confirm_return_to_menu')
		make_visible(false)

func on_cancel() -> void:
	make_visible(false)

@warning_ignore("shadowed_variable_base_class")
func make_visible(is_visible:bool) -> void:
	if is_visible:
		self.show()
	else:
		self.hide()
	
	canvas_layer.visible = is_visible

func set_text(is_quit:bool) -> void:
	is_quitting = is_quit
	
	if is_quit:
		label.text = tr("UI_QUIT_LABEL")
		button_quit.text = tr("UI_QUIT_BUTTON")
		button_cancel.text = tr("UI_DONTQUIT_BUTTON")
	else:
		label.text = tr("UI_RETURNMENU_LABEL")
		button_quit.text = tr("UI_CONFIRM_BUTTON")
		button_cancel.text = tr("UI_CANCEL_BUTTON")
