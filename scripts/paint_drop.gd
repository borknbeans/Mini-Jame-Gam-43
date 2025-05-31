class_name PaintDrop
extends Node2D

@onready var mesh_instance_2d: MeshInstance2D = $MeshInstance2D
@onready var timer: Timer = $Timer

var color: int

func _ready() -> void:
	mesh_instance_2d.modulate = Utility.get_color_obj(color)

func set_color(color: int) -> void: 
	self.color = color

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	var man: Man = body as Man
	man.change_color(color)
