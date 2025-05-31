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

var max_people: int = 25
var time: int = 30
var level: int = 1
var tutorial: bool = false

func _ready() -> void:
	game_timer.start()
	
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


func _on_button_pressed() -> void:
	button.hide()
	Utility.reset_level.emit()
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	game_timer.stop()
	game_timer.start(time)


func _on_game_timer_timeout() -> void:
	continue_button.show()
	get_tree().paused = true
	
	level += 1
	Utility.level_change.emit(level)
	
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
			max_people = 60
		4:
			continue_button.hide()
			game_over.show()
	
	game_timer.start(time)


func _on_continue_button_pressed() -> void:
	continue_button.hide()
	get_tree().paused = false


func _on_tutorial_button_pressed() -> void:
	if tutorial:
		get_tree().paused = false
		tutorial_button.hide()
		tutorial_text_1.hide()
