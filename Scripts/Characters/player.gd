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
@onready var bullet_ray: RayCast2D = $"Bullet ray"
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
var is_in_dialogue = false
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var bubble: AudioStreamPlayer2D = $bubble


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
		bullet_ray.target_position.x = -60
		if !bubble.playing: bubble.play()
	elif direction.x == 1:
		minigun.flip_h = false
		minigun.position.x = 9
		sprite.flip_h = false
		cpu_particles_2d.position.x = -6
		cpu_particles_2d.emitting = true
		bullet_ray.target_position.x = 60
		if !bubble.playing: bubble.play()
	else:
		bubble.stop()
		cpu_particles_2d.emitting = false
	velocity.x = lerp(velocity.x, SPEED*direction.x, .1)
	velocity.y = lerp(velocity.y, VERTICAL_SPEED*direction.y, .2)
	
	if inVortex:
		velocity.x = lerp(velocity.x, (vortex_x-global_position.x)*100, .05)
		velocity.y = lerp(velocity.y, 150.0, .2)
	
	if sprite.flip_h:
		minigun.flip_h = true
		minigun.position.x = -9
		cpu_particles_2d.position.x = 6
		bullet_ray.target_position.x = -60
	else:
		minigun.position.x = 9
		sprite.flip_h = false
		cpu_particles_2d.position.x = -6
		bullet_ray.target_position.x = 60

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dialoug") && has_minigun && !is_in_dialogue:
		if bullet_ray.get_collider():
			explosion.global_position = bullet_ray.get_collision_point()
			gpu_particles_2d.global_position = bullet_ray.get_collision_point()
			explosion.play(.45)
			gpu_particles_2d.restart()
			gpu_particles_2d.emitting = true
			if bullet_ray.get_collider().is_in_group("Destroyable"):
				bullet_ray.get_collider().call_deferred("queue_free")
