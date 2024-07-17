extends Control


@onready var _OptionButton_ :OptionButton = $HBoxContainer/OptionButton


func _ready() -> void:
    _OptionButton_._select_int(0)
    get_node('Doors').show()
    get_node('Fog').hide()


func _on_open_button_pressed () -> void:
    var sceneNum = _OptionButton_.get_item_index(_OptionButton_.get_selected_id())
    SceneManager.load_level(sceneNum)


func _on_settings_button_pressed () -> void:
    SceneManager.load_settings_menu()


func _on_play_button_pressed():

    var tween = get_tree().create_tween()
    tween.tween_callback(func(): 
        get_node('Doors').hide()
        get_node('Fog').show()
    )
    tween.parallel().tween_property(get_node('Starboy'), 'self_modulate:a', 1.0, 2.0).from(0.0)
    tween.tween_callback(func(): 
        SceneManager.load_level(0)
    )
