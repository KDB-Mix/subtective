extends Node2D

@onready var dialoug: NinePatchRect = $CanvasLayer/Dialoug
@onready var npc_kraken: Area2D = $"NPC kraken"
@onready var door_animation_player: AnimationPlayer = $"Locked door/AnimationPlayer"

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
