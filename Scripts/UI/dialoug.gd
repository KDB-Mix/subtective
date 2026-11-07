class_name  Dialoug
extends NinePatchRect

@onready var text: RichTextLabel = $MarginContainer/Text
@onready var virtual_joystick: VirtualJoystick = $"../../Touch screen/VirtualJoystick"

func _ready() -> void:
	text.visible_characters = 0

func _process(delta: float) -> void:
	text.visible_characters = move_toward(text.visible_characters, text.text.length(), 1)
	if visible:
		virtual_joystick.visible = false
	else:
		virtual_joystick.visible = true
