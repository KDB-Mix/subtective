extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var dialoug: NinePatchRect = $"../CanvasLayer/Dialoug"

var dialougs: Array[String] = ["Hello", "How are you?", "Looks like you're stuck", "Luckly, there is a portal to get you out", "Just  head strait, all ways will lead to it", "Be careful, a lot will lie to you, don't trust everyone", "Good luck"]
var external_dialougs: Array[String] = ["Still here?", "Go ahead", "Start your journey", "(silent)", "Uhhh, nothing to do here for now"]
var current_dialoug: int = -1
var finished = false

func _on_body_entered(body: Node2D) -> void:
	icon.visible = true


func _on_body_exited(body: Node2D) -> void:
	icon.visible = false
	dialoug.visible = false
	current_dialoug = -1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dialoug"):
		if has_overlapping_bodies():
			if !finished:
				if current_dialoug == dialougs.size()-1:
					dialoug.visible = false
					current_dialoug = -1
					finished = true
				elif current_dialoug == -1 || dialoug.text.visible_characters >= dialoug.text.text.length():
					current_dialoug += 1
					dialoug.text.text = dialougs.get(current_dialoug)
					dialoug.text.visible_characters = 0
					dialoug.visible = true
				elif dialoug.text.visible_characters < dialoug.text.text.length():
					dialoug.text.visible_characters = dialoug.text.text.length()
			else:
				if current_dialoug != -1:
					dialoug.visible = false
					current_dialoug = -1
				elif current_dialoug == -1:
					current_dialoug = randi_range(0, external_dialougs.size()-1)
					dialoug.text.text = external_dialougs.get(current_dialoug)
					dialoug.text.visible_characters = 0
					dialoug.visible = true
		
