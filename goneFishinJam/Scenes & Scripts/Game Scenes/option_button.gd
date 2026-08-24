extends OptionButton


func _on_item_selected(index: int) -> void:
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("es")
		2:
			TranslationServer.set_locale("fil")
		3:
			TranslationServer.set_locale("zh_CN")
		4:
			pass
