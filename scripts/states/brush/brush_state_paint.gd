class_name BrushStatePaint
extends BrushState

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	if not paint_spawn_delay.timeout.is_connected(_on_timer_timeout):
		paint_spawn_delay.timeout.connect(_on_timer_timeout)
	paint_spawn_delay.start()

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	if paint_spawn_delay.timeout.is_connected(_on_timer_timeout):
		paint_spawn_delay.timeout.disconnect(_on_timer_timeout)
	paint_spawn_delay.stop()

func update(_delta: float) -> void:
	if not Input.is_action_pressed("paint"):
		finished.emit(HOVER)

func _on_timer_timeout() -> void:
	var paint_drop: PaintDrop = brush.paint_drop_scene.instantiate()
	paint_drop.position = brush.position
	paint_drop.set_color(brush.color)
	get_tree().root.call_deferred("add_child", paint_drop)
