class_name ManStateFollow
extends ManState

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	if is_zero_approx(follow_point.distance_to(man.global_position)):
		finished.emit(IDLE)
