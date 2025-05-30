class_name ManStateWander
extends ManState

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	# TODO: Pick a random point within a region to wander to
	pass

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	# TODO: Move towards random point
	
	if follow_point != null:
		finished.emit(FOLLOW)
