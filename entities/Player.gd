extends KinematicBody2D


signal moved
signal timing_changed

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
const DEFAULT_SPEED = 0.2
var timing

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	_screen_size = get_viewport().size
	timing = $Timer.wait_time
	
	
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
	var future_position = position
	
	direction = future_direction
	
	var tween = $Tween
	
	match direction:
		LEFT:
			future_position.x -= step_size
		RIGHT:
			future_position.x += step_size
		UP:
			future_position.y -= step_size
		DOWN:
			future_position.y += step_size
	
	tween.interpolate_property(self, "position", position, future_position, $Timer.wait_time)
	tween.start()
	
	emit_signal("moved", previous_position)
	
func set_size(screen_size):
	_screen_size = screen_size	
	

func increase_speed():
	var MAX_SPEED = 0.06
	$Timer.wait_time = max($Timer.wait_time * 0.95, MAX_SPEED)
	
	timing = $Timer.wait_time
		
func reset():
	$Timer.wait_time = DEFAULT_SPEED
	direction = RIGHT
	future_direction = RIGHT
	$Tween.stop_all()
	$hamhamham.stop()
	$slurp.stop()
	
	position = Vector2(512, 256)
	previous_position = position

func play_eating_sound():
	var sounds = ['hamhamham', 'slurp']
	sounds.shuffle()
	
	get_node(sounds.front()).play()
	
