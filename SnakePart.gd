extends Sprite

signal moved
signal hit_head

var _precursorReference
var previous_position
var timing


func set_precursor(snakePartReference):
	_precursorReference = snakePartReference
	timing = snakePartReference.timing
	_precursorReference.connect("moved", self, "_on_Precursor_moved")
	
	position = _precursorReference.position
	
	hide()

	
func _on_Precursor_moved(precursor_position):
	show()
	previous_position = position
	
	var tween = $Tween
	tween.interpolate_property(self, "position", position, precursor_position, timing)
	tween.start()
	
	emit_signal("moved", previous_position)


func destroy():
	_precursorReference.disconnect("moved", self, "_on_Precursor_moved")
	queue_free()
