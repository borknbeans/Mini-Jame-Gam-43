class_name BrushStateHover
extends BrushState

func update(_delta: float) -> void:
	if Input.is_action_pressed("paint"):
		finished.emit(PAINT)
