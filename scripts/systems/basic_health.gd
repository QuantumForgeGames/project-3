

extends Node


signal died()
signal update(health :float)

const MAX_HEALTH = 100.0

@export var _health :float = 100.0
@export var _owner :Node = null

var id :String = ''


func _ready():
    GameManager.sync_data.connect(on_sync_update)
    id = '%s/%s' %[owner.name, owner.get_path_to(self)]
    var is_ready = GameManager.get_property(id, 'is_ready')
    if not is_ready:
        _health = MAX_HEALTH
        GameManager.set_property(id, 'is_ready', true)
    update.emit(_health)


func take_damage (damage_ :float) -> void:
    _health -= damage_
    update.emit(_health)

    if _health <= 0.0:
        died.emit()
        if _owner.name == 'Player':
            await get_tree().create_timer(1.0).timeout
            SceneManager.load_game_over(false)
        elif _owner.name == 'Boss':
            await get_tree().create_timer(1.0).timeout
            SceneManager.load_game_over(true)
        else: _owner.queue_free()
        return


func take_heal (heal_ :float) -> void:
    _health += heal_
    if _health > MAX_HEALTH:
        _health = MAX_HEALTH
    update.emit(_health)


func on_sync_update (upstream_ :bool) -> void:

    if upstream_:
        GameManager.set_property(id, 'health', _health)
    else:
        var value = GameManager.get_property(id, 'health')
        if not value: return
        _health = value
        update.emit(_health)
