extends Node

@onready var animation_player = $"../../AnimationPlayer"
@onready var health = $"../Health"

func _on_area_2d_area_entered(area):
    if area.is_in_group("door"):
        print("Collide")
        owner.position.x += 300
        animation_player.play("blink")
        health.take_damage(25)

