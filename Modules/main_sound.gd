extends AudioStreamPlayer

func _on_button_container_play_correct_sound():
	playing = true
	
func _on_button_container_set_answer(button):
	print("SETTING THIS SHIT: ", button)
	stream = button.get_node("Container/Sound").stream
