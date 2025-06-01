class_name ManSpawner
extends Node2D

@onready var man_container: Node2D = %ManContainer
@onready var spawn_timer: Timer = $SpawnTimer

@export var man_scene: PackedScene
@export var spawn_delay: float

@export var limit: int = -1

func _ready() -> void:
	spawn_timer.start(spawn_delay)

func _on_spawn_timer_timeout() -> void:
	if not visible or limit == 0:
		return
	
	if limit > 0:
		limit -= 1
	
	var man: Man = man_scene.instantiate()
	
	man.position = position
	
	man_container.call_deferred("add_child", man)
