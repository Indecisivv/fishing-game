extends Control

@onready var ending_header : Label = $VBoxContainer/EndingHeader
@onready var subtitle_1    : Label = $VBoxContainer/Subtitle1
@onready var subtitle_2    : Label = $VBoxContainer/Subtitle2
@onready var subtitle_3    : Label = $VBoxContainer/Subtitle3

@onready var ending_label : Label = $VBoxContainer2/EndingLabel
@onready var ending_title : Label = $VBoxContainer2/EndingTitle


signal restart_game

func set_end_text(header:String, subtitle1:String, subtitle2:String, subtitle3:String) -> void:
	ending_header.text = header
	subtitle_1.text    = subtitle1
	subtitle_2.text    = subtitle2
	subtitle_3.text    = subtitle3

func set_end_label(num:int) -> void:
	ending_label.text = "Ending " + str(num) + "/3"
	
	match num:
		0:
			ending_title.text = "Starving"
		1:
			ending_title.text = "Unsatisfied"
		2:
			ending_title.text = "Room for Dessert"
		3:
			ending_title.text = "Greed from the Bible"

func _on_button_pressed() -> void:
	emit_signal('restart_game')
