
extends Sprite


signal moved


enum {
	LEFT,
	RIGHT,
	UP,
	DOWN	
}

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
		
	emit_signal("moved", previous_position)
		
		
		
		
		
		
