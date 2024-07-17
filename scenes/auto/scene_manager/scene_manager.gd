extends Node


@export var main_menu_scene :PackedScene
@export var settings_menu_scene :PackedScene
@export var level_scenes :Array[PackedScene]

var current_level_instance: Node = null
var settings_menu_instance: Node = null

func _ready () -> void:
    await get_tree().root.ready
    get_tree().root.get_child(-1).queue_free()
    load_main_menu()
    AudioManager.toggle_music()


func load_main_menu():
    change_scene(main_menu_scene)
    # get_tree().change_scene_to_packed(main_menu_scene)

    AudioManager.toggle_music()


func load_level(level_index: int):

    if 0 <= level_index and level_index < level_scenes.size():
        change_scene(level_scenes[level_index])
        # get_tree().change_scene_to_packed(level_scenes[level_index])
    else:
        print("Invalid level index")

    AudioManager.toggle_music()


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
    # var current_scene = get_tree().current_scene


func change_scene(scene_ :PackedScene) -> void:
    GameManager.sync_data.emit(true)
    GameManager.clear_connections()

    if current_level_instance != null:
        current_level_instance.queue_free()
    current_level_instance = scene_.instantiate()
    get_tree().root.add_child(current_level_instance)

    GameManager.sync_data.emit(false)
    # if current_level_instance != null:
    #     current_level_instance.queue_free()
    #     current_level_instance = null
    # var new_scene_instance = scene_.instance()
    # get_tree().root.add_child(new_scene_instance)
