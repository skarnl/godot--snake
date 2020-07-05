extends Sprite

signal moved
signal hit_head

var _precursorReference
var previous_position
var timing


func _on_head_hit(_body):
	if _body.name != _precursorReference.name:
		emit_signal("hit_head")


func set_precursor(snakePartReference):
	_precursorReference = snakePartReference
	_precursorReference.connect("moved", self, "_on_Precursor_moved")
	
	position = _precursorReference.position
	
	$Area2D.connect('body_entered', self, '_on_head_hit')
	
	hide()

	
func _on_Precursor_moved(precursor_position):
	show()
	previous_position = position
	
	timing = _precursorReference.timing
	
	var tween = $Tween
	tween.interpolate_property(self, "position", position, precursor_position, timing)
	tween.start()
	
	emit_signal("moved", previous_position)


func destroy():
	_precursorReference.disconnect("moved", self, "_on_Precursor_moved")
	queue_free()
