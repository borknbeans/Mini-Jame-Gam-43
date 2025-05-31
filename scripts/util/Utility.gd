extends Node

enum COLORS {
	NEUTRAL,
	RED,
	YELLOW,
	BLUE
}

func get_color_obj(color: int) -> Color:
	var color_value: Color = Color.from_rgba8(255, 255, 255, 255)
	
	match (color):
		COLORS.RED:
			color_value = Color.from_rgba8(217, 87, 99)
		COLORS.BLUE:
			color_value = Color.from_rgba8(99, 155, 255)
		COLORS.YELLOW:
			color_value = Color.from_rgba8(251, 242, 54)
	
	return color_value
