extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var dialoug: NinePatchRect = $"../CanvasLayer/Dialoug"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_animation_player: AnimationPlayer = $"../Locked door/AnimationPlayer"

var dialougs: Array[String] = ["Hello", "You want to get past this door?", "There is a key", "Go down until you find the key", "Then get back and unlock the vau...",  "I mean the door...","I'm too large to fit in there", "Good luck"]
var external_dialougs: Array[String] = ["Still here?", "Go ahead", "Go get that key", "(silent)", "Waiting"]
var end_dialogues: Array[String] = ["Thanks for the key", "Won't tell you where is the real one", "I can finally access the bank's vault"]
var failed_dialogues: Array[String] = ["So you took the upper path", "(\"shoot, he got the real one\")", "Looks like it would work", "Go ahead"]
var current_dialoug: int = -1
var finished = false
var player: Player
var ran_away = false

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
			if "real_key" in player.items_owned:
				if current_dialoug == failed_dialogues.size()-1:
						dialoug.visible = false
						current_dialoug = -1
						animation_player.play("Runaway")
						door_animation_player.play("Open")
						player.items_owned.erase("real_key")
						ran_away = true
						player.multiplier = Vector2(1, 1)
				elif current_dialoug == -1 || dialoug.text.visible_characters >= dialoug.text.text.length():
						current_dialoug += 1
						dialoug.text.text = failed_dialogues.get(current_dialoug)
						dialoug.text.visible_characters = 0
						dialoug.visible = true
						player.multiplier = Vector2.ZERO
						player.sprite.flip_h = false
				elif dialoug.text.visible_characters < dialoug.text.text.length():
						dialoug.text.visible_characters = dialoug.text.text.length()
			elif "fake_key" in player.items_owned:
				if current_dialoug == end_dialogues.size()-1:
						dialoug.visible = false
						current_dialoug = -1
						animation_player.play("Runaway")
						player.items_owned.erase("fake_key")
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
				
		
