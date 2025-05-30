class_name Man
extends CharacterBody2D

@export var wander_speed: float = 100
@export var follow_speed: float = 100

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var congregation_area_2d: Area2D

func _ready() -> void:
	congregation_area_2d = get_tree().get_first_node_in_group("congregation_area")
