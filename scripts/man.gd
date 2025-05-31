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
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var color_change_sound: AudioStreamPlayer2D = $ColorChangeSound

var congregation_area_2d: Area2D
var color: int
var follow_point: Vector2

func _ready() -> void:
	congregation_area_2d = get_tree().get_first_node_in_group("congregation_area")
	Utility.reset_level.connect(_on_reset_level)

func _process(delta: float) -> void:
	follow_point = _find_drop_off_for_color(color)

func change_color(color_idx: int) -> void:
	if color == color_idx:
		return
	match (color_idx):
		Utility.COLORS.NEUTRAL:
			sprite_2d.texture = neutral_texture
		Utility.COLORS.RED:
			sprite_2d.texture = red_texture
		Utility.COLORS.BLUE:
			sprite_2d.texture = blue_texture
		Utility.COLORS.YELLOW:
			sprite_2d.texture = yellow_texture
	color = color_idx
	follow_point = _find_drop_off_for_color(color)
	
	color_change_sound.pitch_scale = randf_range(0.8, 1.2)
	color_change_sound.play()
	
	var temp: Color = Utility.get_color_obj(color)
	cpu_particles_2d.color = Color(temp.r - 0.1, temp.g - 0.1, temp.b - 0.1)
	cpu_particles_2d.emitting = true

func _find_drop_off_for_color(drop_off_color: int) -> Vector2:
	var drop_offs = get_tree().get_nodes_in_group("drop_off")
	for drop_off: DropOff in drop_offs:
		if drop_off.color == self.color && not drop_off.blocked && drop_off.visible:
			return drop_off.position
	
	return Vector2.ZERO

func _on_reset_level() -> void:
	queue_free()
