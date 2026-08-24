class_name Player
extends CharacterBody2D


const SPEED = 150.0
const VERTICAL_SPEED = 100.0
var direction: Vector2
var multiplier = Vector2(1, 1)
@onready var sprite: Sprite2D = $Sprite
@onready var animation_tree: AnimationPlayer = $Sprite/AnimationTree
var items_owned: Array[String]



func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("Move left", "Move right")
	direction.y = Input.get_axis("Move up", "Move down")
	direction *= multiplier
	animation_tree.speed_scale = direction.x
	if direction.x == -1:
		sprite.flip_h = true
	elif direction.x == 1:
		sprite.flip_h = false
	velocity.x = lerp(velocity.x, SPEED*direction.x, .1)
	velocity.y = lerp(velocity.y, VERTICAL_SPEED*direction.y, .2)

	move_and_slide()
