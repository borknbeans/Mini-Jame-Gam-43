class_name BrushState
extends State

const DISABLED: String = "BrushStateDisabled"
const HOVER: String = "BrushStateHover"
const PAINT: String = "BrushStatePaint"

var brush: Brush
var mouse_position: Vector2

@onready var mesh_instance_2d: MeshInstance2D = %MeshInstance2D
@onready var paint_spawn_delay: Timer = %PaintSpawnDelay

func _ready() -> void:
	await owner.ready
	brush = owner as Brush
	assert(brush != null, "The BrushState state type must be used only in the Brush scene. It needs the owner to be a Brush node.")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select_paint_1"):
		brush.color = 0
		brush.color_changed.emit(0)
	if Input.is_action_just_pressed("select_paint_2"):
		brush.color = 1
		brush.color_changed.emit(1)
	if Input.is_action_just_pressed("select_paint_3"):
		brush.color = 2
		brush.color_changed.emit(2)
	if Input.is_action_just_pressed("select_paint_4"):
		brush.color = 3
		brush.color_changed.emit(3)

## Called by the state machine when receiving unhandled input events.
func handle_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_move_event: InputEventMouseMotion = event as InputEventMouseMotion
		mouse_position = mouse_move_event.global_position
		brush.position = mouse_position
