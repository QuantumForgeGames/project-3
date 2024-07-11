extends Node


@export var main_menu_scene :PackedScene
@export var settings_menu_scene :PackedScene
@export var level_scenes :Array[PackedScene]

var current_level_instance: Node = null
var settings_menu_instance: Node = null


func load_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)


func load_level(level_index: int):
	if 0 <= level_index and level_index < level_scenes.size():
		get_tree().change_scene_to_packed(level_scenes[level_index])
	else:
		print("Invalid level index")


func load_settings_menu():
	if settings_menu_instance == null:
		settings_menu_instance = settings_menu_scene.instantiate()
		get_tree().root.add_child(settings_menu_instance)
	else:
		get_tree().root.remove_child(settings_menu_instance)
		get_tree().root.add_child(settings_menu_instance)


func show_settings_menu():
	load_settings_menu()
	get_tree().paused = true


func hide_settings_menu():
	if settings_menu_instance != null:
		settings_menu_instance.hide()
	get_tree().paused = false
	var current_scene = get_tree().current_scene
	# 

func change_scene(scene_ :PackedScene) -> void:
	if current_level_instance != null:
		current_level_instance.queue_free()
		current_level_instance = null
	var new_scene_instance = scene_.instance()
	get_tree().root.add_child(new_scene_instance)
