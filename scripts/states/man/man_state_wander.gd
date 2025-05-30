class_name ManStateWander
extends ManState

var random_point: Vector2

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	random_point = _get_random_point()
	man.animation_player.play("move")

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	var direction = man.position.direction_to(random_point)
	man.velocity = direction * man.wander_speed
	
	man.move_and_slide()
	
	if follow_point != Vector2.ZERO:
		finished.emit(FOLLOW)
	if random_point.distance_to(man.position) < 1:
		finished.emit(IDLE)

func _get_random_point() -> Vector2:
	var point = man.congregation_area_2d.position
	var rand = Vector2(randf_range(-1, 1) * man.congregation_area_2d.scale.x * 10, randf_range(-1, 1) * man.congregation_area_2d.scale.y * 10)
	return Vector2(rand.x + point.x, rand.y + point.y)
