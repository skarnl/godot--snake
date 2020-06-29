
extends Sprite


signal moved


enum {
	LEFT,
	RIGHT,
	UP,
	DOWN	
}

var _screen_size
var previous_position
var direction = RIGHT
var future_direction = RIGHT
export var step_size = 32.0

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	

func _on_Timer_timeout():
	move()
	pass
	

func _unhandled_input(event):
	if event is InputEventKey:
		if direction == UP or direction == DOWN:
			if event.is_action_pressed("ui_left"):
				future_direction = LEFT
			elif event.is_action_pressed("ui_right"):
				future_direction = RIGHT
		else:
			if event.is_action_pressed("ui_down"):
				future_direction = DOWN
			elif event.is_action_pressed("ui_up"):
				future_direction = UP


func move()->void:
	previous_position = position
	
	direction = future_direction
	
	match direction:
		LEFT:
			position.x -= step_size
		RIGHT:
			position.x += step_size
		UP:
			position.y -= step_size
		DOWN:
			position.y += step_size
	
	if position.x > _screen_size.x:
		position.x = 32
	elif position.x < 0:
		position.x = _screen_size.x
	
	if position.y > _screen_size.y:
		position.y = 32
	elif position.y < 0:
		position.y = _screen_size.y
		
	emit_signal("moved", previous_position)
	
func set_size(screen_size):
	_screen_size = screen_size	
		
		
		
