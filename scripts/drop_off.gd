class_name DropOff
extends Area2D

signal balance_increased

@export var color: int

var balance: float

func _on_body_entered(body: Node2D) -> void:
	var man: Man = body as Man
	if man.color != color:
		return
	
	balance += 1
	man.queue_free()
	
	balance_increased.emit()
