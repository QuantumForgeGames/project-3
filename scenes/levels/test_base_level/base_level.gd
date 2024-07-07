extends Node2D


func _input(event_ :InputEvent) -> void:
    if event_.is_action_pressed("ui_cancel"):
        SceneManager.show_settings_menu()


func _on_main_button_pressed () -> void:
    SceneManager.load_main_menu()


func _on_settings_button_pressed():
    SceneManager.show_settings_menu()
