class_name DropOff
extends Area2D

@export var color: int
@export var max_balance: int = 10
@export var reduction_timer_length: float = 1
@export var balance_reduction_amount: float = 1

@export var safe_color: Color
@export var medium_danger_color: Color
@export var danger_color: Color

@export_group("Textures")
@export var neutral_drop_off: Texture2D
@export var red_drop_off: Texture2D
@export var yellow_drop_off: Texture2D
@export var blue_drop_off: Texture2D

@export_group("Shake")
@export var shake_strength: float
@export var shake_increment: float = 0.1

var balance: float
var shake_point: Vector2
var shake_weight: float

var blocked: bool

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var last_body_entered: Timer = $LastBodyEntered
@onready var pop_audio: AudioStreamPlayer2D = $PopAudio
@onready var working_audio: AudioStreamPlayer2D = $WorkingAudio

func _ready() -> void:
	_set_color()
	
	shake_point = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_strength
	timer.start(reduction_timer_length)
	
	Utility.reset_level.connect(_on_reset_level)

func _set_color() -> void:
	if color == 1:
		sprite_2d.texture = red_drop_off
	elif color == 2:
		sprite_2d.texture = yellow_drop_off
	elif color == 3:
		sprite_2d.texture = blue_drop_off

func _process(delta: float) -> void:
	if blocked:
		shake()
	
	progress_bar.value = (balance / max_balance) * 100

func _on_body_entered(body: Node2D) -> void:
	var man: Man = body as Man
	if man.color != color:
		return
	
	animation_player.play("collect")
	
	balance += 1
	
	if balance >= max_balance:
		blocked = true
		sprite_2d.texture = neutral_drop_off
		working_audio.pitch_scale = randf_range(0.8, 1.2)
		working_audio.play()
	
	man.queue_free()
	pop_audio.pitch_scale = randf_range(0.8, 1.2)
	pop_audio.play()
	
	last_body_entered.start()
	
	if Utility.first_time_drop_off:
		Utility.first_time_drop_off = false
		Utility.drop_off_tutorial_signal.emit()

func shake() -> void:
	sprite_2d.offset = sprite_2d.offset.slerp(shake_point, shake_weight)
	shake_weight += shake_increment
	
	if shake_weight >= 1:
		shake_weight = 0
		shake_point = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_strength

func _on_timer_timeout() -> void:
	if not last_body_entered.is_stopped():
		return
	
	balance -= balance_reduction_amount
	balance = clampf(balance, 0, 999)
	if balance <= 0:
		blocked = false
		_set_color()
		working_audio.stop()

func _on_reset_level() -> void:
	balance = 0
	blocked = false
