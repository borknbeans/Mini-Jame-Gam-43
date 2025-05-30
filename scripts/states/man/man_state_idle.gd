class_name ManStateIdle
extends ManState

@export var min_idle_time: float = 1
@export var max_idle_time: float = 3

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	man.velocity = Vector2.ZERO
	man.animation_player.stop()
	
	var idle_time: float = randf_range(min_idle_time, max_idle_time)
	idle_timer.start(idle_time)
	
	if not idle_timer.timeout.is_connected(_on_idle_timer_timeout):
		idle_timer.timeout.connect(_on_idle_timer_timeout)

## Called by the state machine on the engine's main loop tick.
func physics_update(_delta: float) -> void:
	if follow_point != Vector2.ZERO:
		finished.emit(FOLLOW)

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	if idle_timer.timeout.is_connected(_on_idle_timer_timeout):
		idle_timer.timeout.disconnect(_on_idle_timer_timeout)

func _on_idle_timer_timeout() -> void:
	finished.emit(WANDER)
