extends AudioStreamPlayer

func _on_set_answer(button):
	print("SETTING THIS SHIT: ", button)
	stream = button.get_node("Container/Sound").stream

func _on_play_correct_sound():
	playing = true
