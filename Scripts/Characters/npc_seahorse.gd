extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var dialoug: NinePatchRect = $"../CanvasLayer/Dialoug"

var dialougs: Array[String] = ["Hello", "How are you?", "You want to get to the other side?", "The way is in that cave under us", "There is a vortex in the upper path, it is dangerous", "Good luck"]
var external_dialougs: Array[String] = ["Still here?", "Go ahead", "...", "(silent)", "Uhhh, nothing to do here for now"]
var current_dialoug: int = -1
var finished = false
var player: Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		icon.visible = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		icon.visible = false
		dialoug.visible = false
		current_dialoug = -1
		player.multiplier = Vector2(1, 1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dialoug"):
		if has_overlapping_bodies():
			if !finished:
				if current_dialoug == dialougs.size()-1:
					dialoug.visible = false
					current_dialoug = -1
					finished = true
					player.multiplier = Vector2(1, 1)
				elif current_dialoug == -1 || dialoug.text.visible_characters >= dialoug.text.text.length():
					current_dialoug += 1
					dialoug.text.text = dialougs.get(current_dialoug)
					dialoug.text.visible_characters = 0
					dialoug.visible = true
					player.multiplier = Vector2.ZERO
					player.sprite.flip_h = false
				elif dialoug.text.visible_characters < dialoug.text.text.length():
					dialoug.text.visible_characters = dialoug.text.text.length()
			else:
				if current_dialoug != -1:
					dialoug.visible = false
					current_dialoug = -1
					player.multiplier = Vector2(1, 1)
				elif current_dialoug == -1:
					current_dialoug = randi_range(0, external_dialougs.size()-1)
					dialoug.text.text = external_dialougs.get(current_dialoug)
					dialoug.text.visible_characters = 0
					dialoug.visible = true
					player.multiplier = Vector2.ZERO
					player.sprite.flip_h = false
		
