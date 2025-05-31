class_name ManStateFollow
extends ManState

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	man.animation_player.play("move")

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	var direction = man.position.direction_to(man.follow_point)
	man.velocity = direction * man.follow_speed
	
	man.move_and_slide()
	
	if is_zero_approx(man.follow_point.distance_to(man.global_position)):
		finished.emit(IDLE)
	elif man.follow_point == Vector2.ZERO:
		finished.emit(IDLE)
