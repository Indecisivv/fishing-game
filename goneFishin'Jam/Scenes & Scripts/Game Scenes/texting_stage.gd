extends Control
	
func load_timeline(timeline:String) -> void:
	Dialogic.Styles.load_style('SmartphoneStyle')
	Dialogic.start(timeline)
