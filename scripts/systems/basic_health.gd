

extends Node


signal died()
signal update(health :float)

const MAX_HEALTH = 100.0

@export var _health :float = 100.0
@export var _owner :Node = null


func _ready():
	_health = MAX_HEALTH
	update.emit(_health)


func take_damage (damage_ :float) -> void:
	_health -= damage_
	if _health <= 0.0:
		died.emit()
		_owner.queue_free()
		return
	update.emit(_health)


func take_heal (heal_ :float) -> void:
	_health += heal_
	if _health > MAX_HEALTH:
		_health = MAX_HEALTH
	update.emit(_health)

