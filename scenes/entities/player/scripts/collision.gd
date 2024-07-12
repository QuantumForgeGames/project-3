extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("bot"):
		print("Collide")
		get_tree().get_nodes_in_group("bot")[0].get_parent().queue_free()
		get_tree().get_nodes_in_group("door")[0].set_door_open()
		#get_parent().get_node("bot").queue_free()
		
	# We need to kill the bot
	# And the door needs to be opened.
	# So we need to tell the level that the card has been collected.
