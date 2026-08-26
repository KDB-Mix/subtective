extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var dialoug: NinePatchRect = $"../CanvasLayer/Dialoug"

var dialougs: Array[String] = ["Hello", "Looking for the portal?", "It is over there", "Go behind me"]
var external_dialougs: Array[String] = ["Still here?", "Go ahead", "(silent)"]
var end_dialogues: Array[String] = ["Why did you take that path?", "Told you it is behind me"]
var current_dialoug: int = -1
var finished = false
var player: Player
var ran_away = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		icon.visible = true
		player = body
		player.is_in_dialogue = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		icon.visible = false
		dialoug.visible = false
		current_dialoug = -1
		player.multiplier = Vector2(1, 1)
		player.is_in_dialogue = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dialoug"):
		if has_overlapping_bodies():
			if "wrong_path" in player.items_owned:
				if current_dialoug == end_dialogues.size()-1:
						dialoug.visible = false
						current_dialoug = -1
						player.items_owned.erase("wrong_path")
						ran_away = true
						player.multiplier = Vector2(1, 1)
				elif current_dialoug == -1 || dialoug.text.visible_characters >= dialoug.text.text.length():
						current_dialoug += 1
						dialoug.text.text = end_dialogues.get(current_dialoug)
						dialoug.text.visible_characters = 0
						dialoug.visible = true
						player.multiplier = Vector2.ZERO
						player.sprite.flip_h = false
				elif dialoug.text.visible_characters < dialoug.text.text.length():
						dialoug.text.visible_characters = dialoug.text.text.length()
			else:
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
				
		
