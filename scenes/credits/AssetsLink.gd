@tool
extends VBoxContainer
class_name AssetLink

@export var title: String
@export var link: String

@onready var title_label: Label = %Title
@onready var link_button: LinkButton = %LinkButton


func _ready():
	self.title_label.text = title
	self.link_button.text = link
	self.link_button.uri = link
