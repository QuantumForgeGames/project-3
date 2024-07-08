extends ParallaxBackground

const SCROLL_SPEED :float = 200.0


func _process (delta_ :float) -> void:
    scroll_offset.x -= SCROLL_SPEED * delta_
    
