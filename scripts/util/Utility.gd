extends Node

signal game_start
signal reset_level
signal level_change(level: int)
signal drop_off_tutorial_signal

var first_time_drop_off: bool = true

enum COLORS {
	NEUTRAL,
	RED,
	YELLOW,
	BLUE
}

func get_color_obj(color: int) -> Color:
	var color_value: Color = Color.from_rgba8(53, 53, 53, 255)
	
	match (color):
		COLORS.RED:
			color_value = Color.from_rgba8(217, 87, 99)
		COLORS.BLUE:
			color_value = Color.from_rgba8(99, 155, 255)
		COLORS.YELLOW:
			color_value = Color.from_rgba8(250, 242, 54)
	
	return color_value
