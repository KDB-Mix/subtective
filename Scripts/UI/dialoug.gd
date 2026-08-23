class_name  Dialoug
extends NinePatchRect

@onready var text: RichTextLabel = $MarginContainer/Text

func _ready() -> void:
	text.visible_characters = 0

func _process(delta: float) -> void:
	text.visible_characters = move_toward(text.visible_characters, text.text.length(), 1)
