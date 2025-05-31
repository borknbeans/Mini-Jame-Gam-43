class_name Brush
extends Node2D

signal color_changed(color: int)

@export var paint_drop_scene: PackedScene
@export var color: int

@onready var change_brush_audio: AudioStreamPlayer2D = $ChangeBrushAudio
