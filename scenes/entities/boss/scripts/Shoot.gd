extends State

@export var bullet_node: PackedScene

@onready var bullet_position = $"../../BulletPosition"

var can_transition: bool = false
var amount_of_shots: int = 5

func enter():
    super.enter()
    for _x in amount_of_shots:
        await shoot()
    can_transition = true

func instantiate_bullet():
    var bullet = bullet_node.instantiate()
    #bullet.position = owner.position
    bullet.position = bullet_position.global_position
    # get_tree().current_scene.add_child(bullet)
    SceneManager.current_level_instance.add_child(bullet)

func transition():
    if can_transition:
        can_transition = false
        get_parent().change_state("Idle")

func shoot():
    animation_player.play("attack")
    await animation_player.animation_finished
    instantiate_bullet()
    AudioManager.play_stream_oneshot(AudioManager.audio_boss_laser)
