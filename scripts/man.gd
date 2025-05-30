class_name Man
extends CharacterBody2D

@export var wander_speed: float = 100
@export var follow_speed: float = 100

@export var neutral_texture: Texture2D
@export var red_texture: Texture2D
@export var blue_texture: Texture2D
@export var yellow_texture: Texture2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var congregation_area_2d: Area2D

func _ready() -> void:
	congregation_area_2d = get_tree().get_first_node_in_group("congregation_area")

func change_color(color_idx: int) -> void:
	match (color_idx):
		Utility.COLORS.NEUTRAL:
			sprite_2d.texture = neutral_texture
		Utility.COLORS.RED:
			sprite_2d.texture = red_texture
		Utility.COLORS.BLUE:
			sprite_2d.texture = blue_texture
		Utility.COLORS.YELLOW:
			sprite_2d.texture = yellow_texture
