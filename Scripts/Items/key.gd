extends Area2D

@export var id = "fake_key"
var player:Player
@onready var icon: Sprite2D = $icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		icon.visible = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		icon.visible = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dialoug"):
		if has_overlapping_bodies():
			player.items_owned.append(id)
			queue_free()
