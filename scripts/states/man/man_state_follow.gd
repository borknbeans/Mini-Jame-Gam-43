class_name ManStateFollow
extends ManState

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	var direction = man.position.direction_to(follow_point)
	man.velocity = direction * man.follow_speed
	
	man.move_and_slide()
	
	if is_zero_approx(follow_point.distance_to(man.global_position)):
		finished.emit(IDLE)
