extends SubViewportContainer

func _input(event):
	for child in get_children():
		if child is SubViewport:
			if event is InputEventMouse:
				var e = event.duplicate()

				# Scale mouse position into the SubViewport
				var scale = child.size / size
				e.position = event.position * scale

				child.push_input(e)
			else:
				child.push_input(event)
