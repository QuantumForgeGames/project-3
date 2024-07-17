extends Control


@onready var _OptionButton_ :OptionButton = $HBoxContainer/OptionButton


func _ready() -> void:
	_OptionButton_._select_int(0)


func _on_open_button_pressed () -> void:
	var sceneNum = _OptionButton_.get_item_index(_OptionButton_.get_selected_id())
	SceneManager.load_level(sceneNum)


func _on_settings_button_pressed () -> void:
	SceneManager.load_settings_menu()


func _on_play_button_pressed():
	SceneManager.load_level(0)
