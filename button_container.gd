extends Container

signal set_answer(button: MarginContainer)
signal has_answered(is_correct: bool)
signal play_correct_sound
signal update_points(point_amount: int)

# Called when the node enters the scene tree for the first time.

const BUTTON = preload("res://Button/button.tscn")
const audio_data = preload("res://Assets/audio_data.gd")
const color_data = preload("res://Assets/color_data.gd")

const result_text = {
	none = "",
	correct = "That's the correct answer",
	incorrect = "That's the wrong answer",
}


@export var stages: int = 5
@export var options_per_stage = 3

var points: int = 0
var stage_index: int = 0
var existing_buttons: Array

var colors: Array = color_data.DATA.duplicate(true)
const sounds: Dictionary = audio_data.DATA

# VALJDA KJE TREBA ARRAY OD VEKJE GENERIRANI KOOPCHINAJ
var loaded_buttons: Array
var generated_buttons: Array

var sound_color_pairs = {
	# note: String,
	# sound: AudioStreamWAV,
	# color: Color
}

var correct_index: int
var correct_color: Color
var correct_sound: AudioStreamWAV

func _ready():
	generate_color_pairs(12, 1)
	print(sound_color_pairs.keys())
	update_points.emit(0)
	
	loaded_buttons = $Colors.get_children()
	if loaded_buttons.size() > 0:
		load_buttons()	
		
	next_question(options_per_stage)
	#generate_buttons(12, true)
	enable_buttons(true)

func generate_color_pairs(note_range: int = 3, semitone_skip: int = 4):
	colors.shuffle()
	var index = 0
	
	for i in note_range:
		sound_color_pairs[sounds.keys()[index]] = {
			note = sounds.keys()[index],
			sound = sounds.values()[index],
			color = colors[index],
		}
		index = (index + semitone_skip) % sounds.size() # Every OTHER note (in this case: C, E, G)

func init_stage():
	enable_buttons(false)
	
	await get_tree().create_timer(2).timeout # wait before initially playing the answer
	play_correct_sound.emit() 
	
	await get_tree().create_timer(2).timeout
	enable_buttons(true)

func next_question(number_of_questions: int):
	await get_tree().create_timer(2).timeout
	
	if stage_index < stages:
		for child in $Colors.get_children():
			$Colors.remove_child(child)
		generate_buttons(options_per_stage)
		stage_index += 1
		init_stage()
	else:
		print("NO MORE STAGES WTF")

func enable_buttons(enable: bool = true):
	for child in $Colors.get_children():
		if enable:
			child.get_node("Container/Button").disabled = false
		else:
			child.get_node("Container/Button").disabled = true
#
#func update_points(point_amount: int = 0):
	#update_points.emit(point_amount)
	
	# MAYBE ADD SOUND EFFECTS FOR EVERYTHING
	# material.set_shader_parameter("some_value", some_value)
	# material.set_shader_parameter("colors", [Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1)])

func load_buttons():
	correct_index = randi_range(0, loaded_buttons.size() - 1)
	
	for button in loaded_buttons:
		var target_sound = button.get_node("Container/Sound").stream
		button.color_clicked.connect(Callable(check_answer.bind(button)))
		#button.get_node("Container/Button").disabled = true
		for key in sound_color_pairs:
			var audition_sound = sound_color_pairs[key].sound
			if(audition_sound == target_sound):
				var new_color = sound_color_pairs[key].color
				var new_text = key
				var loaded_sound = button.get_node("Container/Sound").stream
				button.color_hover = new_color.lightened(0.5)
				
				button.configure_button(loaded_sound, new_color, new_text)
				
		if correct_index == button.get_index():
			set_correct_answer(button)

func set_correct_answer(button: MarginContainer):
	set_answer.emit(button)
	correct_color = button.get_node("Container/Color").color
	correct_sound = button.get_node("Container/Sound").stream
	$CorrectNote.text = "Correct note: " + button.get_node("Container/NoteName").text

func check_existing_button(index) -> int:
	var note_name = sound_color_pairs.keys()
	index = index % note_name.size()
	
	if existing_buttons.has(note_name[index]):
		return check_existing_button(index + 1)
	else:
		existing_buttons.append(note_name[index])
	return index
	
func generate_buttons(number_of_buttons: int, first_time: bool = false):
	var i = 0
	if first_time:
		sound_color_pairs.values().shuffle()
	var new_correct_index = randi_range(0, number_of_buttons - 1)
	if (new_correct_index != correct_index):
		correct_index = new_correct_index
	
	correct_index = randi_range(0, number_of_buttons - 1)
	print("CORRECT INDEX: ", correct_index)
	
	var somethin: Array
	while i < number_of_buttons:
		var index = check_existing_button(randi_range(0, sound_color_pairs.values().size() - 1))
		var button_data = sound_color_pairs.values()[index]

		var new_button = BUTTON.instantiate()
		
		var new_color: Color = button_data.color
		var new_sound: AudioStreamWAV = button_data.sound
		var new_label: String = button_data.note
		
		new_button.color_value = new_color
		new_button.color_hover = new_color.lightened(0.5)
		
		new_button.color_clicked.connect(Callable(check_answer).bind(new_button))
		new_button.configure_button(new_sound, new_color, new_label)
		
		if correct_index == i: 
			set_correct_answer(new_button)
		
		$Colors.add_child(new_button)
		i += 1
	existing_buttons.clear()

func check_answer(button):
	print("CHECKING ANSWER")
	print('Button: ', button, ', correct sound: ', correct_sound, ', button sound: ', button.get_node("Container/Sound").stream)
	if correct_sound == button.get_node("Container/Sound").stream:
		has_answered.emit(true)
		update_points.emit(10)
		
		enable_buttons(false)
		await get_tree().create_timer(2).timeout
		next_question(options_per_stage)
	else:
		print("You guessed the WRONG color")
		has_answered.emit(false)
		#update_points(-5)
		update_points.emit(-5)
		
		enable_buttons(false)
		#enabledd_buttons.emit(false)
		await get_tree().create_timer(2).timeout
		next_question(options_per_stage)

func mix_color(colors: Array[Color]) -> Color:
	# Mix two or more Colors
	var new_color: Color
	var color_sum: Color
	
	for color in colors:
		color_sum += color
	return color_sum / colors.size()
