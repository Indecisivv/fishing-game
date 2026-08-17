extends Sprite2D

func _process(delta: float) -> void:
	var visible_rect: Rect2 = get_viewport_rect()
	var target_pos: Vector2 = get_global_mouse_position()
	
	# Clamp mouse coordinates inside the viewport bounds
	target_pos.x = clamp(target_pos.x, visible_rect.position.x, visible_rect.end.x)
	target_pos.y = clamp(target_pos.y, visible_rect.position.y, visible_rect.end.y)
	
	position += (target_pos / 4 * delta) - position
