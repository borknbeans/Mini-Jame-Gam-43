class_name ManStateWander
extends ManState

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	if follow_point != null:
		finished.emit(FOLLOW)
