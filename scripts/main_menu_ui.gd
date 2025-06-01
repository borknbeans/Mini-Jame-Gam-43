extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_button_pressed() -> void:
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.3).timeout
	Utility.game_start.emit()
