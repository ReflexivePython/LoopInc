extends Label


func show_text_typing(text: String, delay := 0.05) -> void:
	self.text = ""
	for i in text.length():
		self.text += text[i]
		await get_tree().create_timer(delay).timeout
