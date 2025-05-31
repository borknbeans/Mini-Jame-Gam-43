class_name BrushStateDisabled
extends BrushState

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	mesh_instance_2d.hide()

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	mesh_instance_2d.show()
