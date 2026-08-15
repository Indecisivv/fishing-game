extends Node2D

# gone fishin
func _ready() -> void:
	Dialogic.Styles.load_style('SmartphoneStyle')
	Dialogic.start('res://Timelines/TestTimeline.dtl')
