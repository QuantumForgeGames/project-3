extends Node

# @onready var animation_player = $"../../AnimationPlayer"
@onready var sprite = $'../../view/Sprite'
@onready var health = $"../Health"

func _on_area_2d_area_entered(area):
    if area.is_in_group("door"):
        owner.position.x += 300
        # animation_player.play("blink")
        sprite.animation_finished.connect(func(): sprite.frame = 0)
        sprite.play('default')
        health.take_damage(25)

    if area.is_in_group("boss"):
        sprite.animation_finished.connect(func(): sprite.frame = 0)
        sprite.play('default')
        health.take_damage(50)

