class_name DropOff
extends Area2D

@export var color: int
@export var desired_balance: int = 10
@export var forgiveness_balance: int = 5
@export var reduction_timer_length: float = 1
@export var balance_reduction_amount: float = 1

@export var safe_color: Color
@export var medium_danger_color: Color
@export var danger_color: Color

@export_group("Textures")
@export var red_drop_off: Texture2D
@export var yellow_drop_off: Texture2D
@export var blue_drop_off: Texture2D

@export_group("Shake")
@export var shake_strength: float
@export var shake_increment: float
@export var max_shake_strength: int = 52

var balance: float
var shake_point: Vector2
var shake_weight: float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var last_body_entered: Timer = $LastBodyEntered

func _ready() -> void:
	if color == 1:
		sprite_2d.texture = red_drop_off
	elif color == 2:
		sprite_2d.texture = yellow_drop_off
	elif color == 3:
		sprite_2d.texture = blue_drop_off
	
	shake_point = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_strength
	timer.start(reduction_timer_length)

func _process(delta: float) -> void:
	var weight = clampf((balance - desired_balance) / (forgiveness_balance), 0, 1)
	shake_strength = lerp(0, max_shake_strength, weight)
	
	progress_bar.value = (balance / desired_balance) * 100
	
	shake()

func _on_body_entered(body: Node2D) -> void:
	var man: Man = body as Man
	if man.color != color:
		return
	
	animation_player.play("collect")
	
	balance += 1
	man.queue_free()
	
	if balance >= desired_balance + forgiveness_balance:
		print("GAME OVER")
	
	last_body_entered.start()

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
