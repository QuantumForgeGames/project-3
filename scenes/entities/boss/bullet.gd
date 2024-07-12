extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_parent().find_child("Player") # REMOVE


var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


@export var speed: float = 15


func _ready():
    direction = (player.position - position).normalized()


func _physics_process(delta):
    velocity = direction * speed
    rotation = velocity.angle()
    
    velocity = velocity.limit_length(150)
    
    position += velocity


func _on_body_entered(body):
    queue_free()
