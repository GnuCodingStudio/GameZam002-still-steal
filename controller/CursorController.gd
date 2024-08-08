extends Node

@onready var _default = load("res://assets/mouse/default.png")
@onready var _wrench = load("res://assets/mouse/tool_wrench.png")
@onready var _scope = load("res://assets/mouse/scope.png")

func reset_default():
	Input.set_custom_mouse_cursor(_default)


func use_wrench():
	Input.set_custom_mouse_cursor(_wrench)


func use_scope():
	Input.set_custom_mouse_cursor(_scope)
