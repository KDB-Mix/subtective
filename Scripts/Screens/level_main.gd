extends Node2D

@onready var dialoug: NinePatchRect = $CanvasLayer/Dialoug
@onready var npc_kraken: Area2D = $"NPC kraken"
@onready var door_animation_player: AnimationPlayer = $"Locked door/AnimationPlayer"
@onready var npc_seahorse: Area2D = $"NPC seahorse"
@onready var deadend: Area2D = $deadend
@onready var vortex: Area2D = $Vortex
@onready var deadend_2: Area2D = $deadend2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialoug.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_unlock_area_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		if npc_kraken.ran_away && "real_key" in player.items_owned:
			door_animation_player.play("Open")


func _on_deadend_body_entered(body: Node2D) -> void:
	if body is Player:
		npc_seahorse.call_deferred("queue_free")
		deadend.call_deferred("queue_free")


func _on_vortex_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.inVortex = true
		player.vortex_x = vortex.global_position.x


func _on_vortex_body_exited(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.inVortex = false


func _on_deadend_2_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.items_owned.append("wrong_path")
		deadend_2.call_deferred("queue_free")
