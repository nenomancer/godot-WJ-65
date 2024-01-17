extends TextureRect

func _on_has_answered(is_correct):
	print("ANSWERED!", is_correct)
	print(texture)
	texture.color_ramp.colors[0] = Color.REBECCA_PURPLE
	pass # Replace with function body.

func _on_button_container_has_answered(is_correct):
	print("ANSWERED!", is_correct)
	print(texture)
	texture.color_ramp.colors[0] = Color.REBECCA_PURPLE
