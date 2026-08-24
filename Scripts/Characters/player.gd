class_name Player
extends CharacterBody2D


const SPEED = 150.0
const VERTICAL_SPEED = 100.0
var direction: Vector2
var multiplier = Vector2(1, 1)
@onready var sprite: Sprite2D = $Sprite
@onready var animation_tree: AnimationPlayer = $Sprite/AnimationTree
var items_owned: Array[String]
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
var inVortex = false
var vortex_x: float
@onready var minigun: AnimatedSprite2D = $minigun
var has_minigun = false


func _physics_process(delta: float) -> void:
	minigun.visible = has_minigun
	direction.x = Input.get_axis("Move left", "Move right")
	direction.y = Input.get_axis("Move up", "Move down")
	direction *= multiplier
	animation_tree.speed_scale = direction.x
	if direction.x == -1:
		sprite.flip_h = true
		minigun.flip_h = true
		minigun.position.x = -9
		cpu_particles_2d.position.x = 6
		cpu_particles_2d.emitting = true
	elif direction.x == 1:
		minigun.flip_h = false
		minigun.position.x = 9
		sprite.flip_h = false
		cpu_particles_2d.position.x = -6
		cpu_particles_2d.emitting = true
	else:
		cpu_particles_2d.emitting = false
	velocity.x = lerp(velocity.x, SPEED*direction.x, .1)
	velocity.y = lerp(velocity.y, VERTICAL_SPEED*direction.y, .2)
	
	if inVortex:
		velocity.x = lerp(velocity.x, (vortex_x-global_position.x)*100, .05)
		velocity.y = lerp(velocity.y, 150.0, .2)

	move_and_slide()
