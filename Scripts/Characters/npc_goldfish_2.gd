extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var dialoug: NinePatchRect = $"../CanvasLayer/Dialoug"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialougs: Array[String] = ["Haha", 
"Did you think i will let you in?", 
"I closed it with rocks",
"The only way through", 
"Is to explode it", 
"Hahaha"]
var current_dialoug: int = -1
var finished = false
var player: Player

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
			if !finished:
				if current_dialoug == dialougs.size()-1:
					dialoug.visible = false
					current_dialoug = -1
					finished = true
					player.multiplier = Vector2(1, 1)
					animation_player.play("run away")
				elif current_dialoug == -1 || dialoug.text.visible_characters >= dialoug.text.text.length():
					current_dialoug += 1
					dialoug.text.text = dialougs.get(current_dialoug)
					dialoug.text.visible_characters = 0
					dialoug.visible = true
					player.multiplier = Vector2.ZERO
					player.sprite.flip_h = false
				elif dialoug.text.visible_characters < dialoug.text.text.length():
					dialoug.text.visible_characters = dialoug.text.text.length()
		
