extends Area2D

var player:Player
@onready var icon: Sprite2D = $icon
@onready var sfx: AudioStreamPlayer2D = $sfx
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

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
			player.has_minigun = true
			sfx.play()
			visible = false
			collision_shape_2d.disabled = true
			await get_tree().create_timer(1.0).timeout
			call_deferred("queue_free")
