extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var button: Button = $Button
@onready var game_timer: Timer = $GameTimer
@onready var timer_label: Label = $TimerLabel
@onready var red_drop_off: DropOff = $RedDropOff
@onready var yellow_drop_off: DropOff = $YellowDropOff
@onready var blue_drop_off: DropOff = $BlueDropOff
@onready var man_spawner: ManSpawner = $ManSpawner
@onready var continue_button: Button = $ContinueButton
@onready var man_spawner_2: ManSpawner = $ManSpawner2
@onready var man_spawner_3: ManSpawner = $ManSpawner3
@onready var game_over: Label = $GameOver
@onready var tutorial_text_1: Label = $TutorialText1
@onready var tutorial_button: Button = $TutorialButton
@onready var brush: Brush = $Brush
@onready var clear_color: MeshInstance2D = $ClearColor
@onready var red_color: MeshInstance2D = $RedColor
@onready var yellow_color: MeshInstance2D = $YellowColor
@onready var blue_color: MeshInstance2D = $BlueColor
@onready var tutorial_text_2: Label = $TutorialText2
@onready var tutorial_text_3: Label = $TutorialText3
@onready var tutorial_text_4: Label = $TutorialText4
@onready var level_win_sound: AudioStreamPlayer2D = $LevelWinSound

var max_people: int = 25
var time: int = 30
var level: int = 1
var tutorial: bool = false
var tutorial_step: int = 1

func _ready() -> void:
	game_timer.start()
	
	brush.color_changed.connect(_on_brush_color_changed)
	Utility.drop_off_tutorial_signal.connect(_on_first_time_drop_off)
	_on_brush_color_changed(0)
	
	await get_tree().create_timer(1).timeout
	tutorial_text_1.show()
	tutorial = true
	tutorial_button.show()
	get_tree().paused = true


func _process(delta: float) -> void:
	var num_people = get_tree().get_nodes_in_group("man").size()
	progress_bar.value = (num_people / (float)(max_people)) * 100
	
	if progress_bar.value >= 100:
		get_tree().paused = true
		button.show()
	
	timer_label.text = str((int)(game_timer.time_left))

func _on_brush_color_changed(color: int) -> void:
	var x = 480
	var y = 650
	
	var sep = 60
	
	match (color):
		0:
			clear_color.position = Vector2(x, y - 20)
			red_color.position = Vector2(x + (60 * 1), y)
			yellow_color.position = Vector2(x + (60 * 2), y)
			blue_color.position = Vector2(x + (60 * 3), y)
		1:
			clear_color.position = Vector2(x, y)
			red_color.position = Vector2(x + (60 * 1), y - 20)
			yellow_color.position = Vector2(x + (60 * 2), y)
			blue_color.position = Vector2(x + (60 * 3), y)
		2:
			clear_color.position = Vector2(x, y)
			red_color.position = Vector2(x + (60 * 1), y)
			yellow_color.position = Vector2(x + (60 * 2), y - 20)
			blue_color.position = Vector2(x + (60 * 3), y)
		3:
			clear_color.position = Vector2(x, y)
			red_color.position = Vector2(x + (60 * 1), y)
			yellow_color.position = Vector2(x + (60 * 2), y)
			blue_color.position = Vector2(x + (60 * 3), y - 20)

func _on_button_pressed() -> void:
	button.hide()
	Utility.reset_level.emit()
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	game_timer.stop()
	game_timer.start(time)

func _on_first_time_drop_off() -> void:
	tutorial = true
	tutorial_button.show()
	tutorial_text_4.show()
	get_tree().paused = true
	

func _on_game_timer_timeout() -> void:
	continue_button.show()
	get_tree().paused = true
	
	level += 1
	Utility.level_change.emit(level)
	level_win_sound.play()
	
	match (level):
		2:
			time = 60
			yellow_drop_off.show()
			blue_drop_off.show()
			man_spawner.spawn_delay = 0.5
			man_spawner_2.show()
			Utility.reset_level.emit()
			max_people = 40
		3:
			man_spawner.spawn_delay = 0.5
			man_spawner_3.show()
			Utility.reset_level.emit()
			max_people = 75
			red_drop_off.max_balance = 18
			blue_drop_off.max_balance = 18
			yellow_drop_off.max_balance = 18
		4:
			continue_button.hide()
			game_over.show()
	
	game_timer.start(time)


func _on_continue_button_pressed() -> void:
	continue_button.hide()
	get_tree().paused = false


func _on_tutorial_button_pressed() -> void:
	if tutorial:
		tutorial_step += 1
		get_tree().paused = false
		tutorial_button.hide()
		tutorial_text_1.hide()
		tutorial_text_2.hide()
		tutorial_text_3.hide()
		tutorial_text_4.hide()
		
		match tutorial_step:
			2:
				tutorial_button.show()
				tutorial_text_2.show()
				tutorial = true
				get_tree().paused = true
			3:
				tutorial_button.show()
				tutorial_text_3.show()
				tutorial = true
				get_tree().paused = true
