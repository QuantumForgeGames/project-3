extends Node2D

# var boss_room = preload("res://scenes/levels/boss_room/boss_room.tscn").instantiate()
var boss_room = preload("res://scenes/levels/boss_room/boss_room.tscn")
# Add the node as a child of the node the script is attached to.



func _input(event_ :InputEvent) -> void:
	if event_.is_action_pressed("ui_cancel"):
		SceneManager.show_settings_menu()


func _on_main_button_pressed () -> void:
	SceneManager.load_main_menu()


func _on_settings_button_pressed():
	SceneManager.show_settings_menu()


func _on_test_timer_timeout():
	SceneManager.change_scene(boss_room)

# func _process(delta):
#     SceneManager.change_scene(boss_room)
