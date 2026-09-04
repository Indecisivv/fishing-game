extends OptionButton


func _on_item_selected(index: int) -> void:
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("es")
		2:
			TranslationServer.set_locale("zh_CN")
		#3:
			#TranslationServer.set_locale("fil")
			#CharacterLibrary.update_translations() 
		#4:
			#pass
