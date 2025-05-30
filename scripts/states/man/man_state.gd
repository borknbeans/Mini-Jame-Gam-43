class_name ManState
extends State

const IDLE: String = "ManStateIdle"
const WANDER: String = "ManStateWander"
const FOLLOW: String = "ManStateFollow"

var man: Man
var follow_point: Vector2

@onready var idle_timer: Timer = %IdleTimer

func _ready() -> void:
	await owner.ready
	man = owner as Man
	assert(man != null, "The ManState state type must be used only in the Man scene. It needs the owner to be a Man node.")
