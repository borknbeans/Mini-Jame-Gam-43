extends Node2D

@export var main_scene: PackedScene

func _ready() -> void:
	Utility.game_start.connect(_on_game_start)

func _on_game_start() -> void:
	get_tree().change_scene_to_packed(main_scene)
