extends Control

signal start_game

enum {
	LEFT,
	RIGHT,
	UP,
	DOWN	
}

func _ready():
	hide()
	set_process_input(false)
	
	
func show():
	.show()
	$AnimationPlayer.play("controls")
	set_process_input(true)
	
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed('ui_left', true) or event.is_action_pressed('ui_right', true) or event.is_action_pressed('ui_up', true) or event.is_action_pressed('ui_down', true):
			var direction
			
			if event.is_action_pressed("ui_left"):
				direction = LEFT
			elif event.is_action_pressed("ui_right"):
				direction = RIGHT
			elif event.is_action_pressed("ui_down"):
				direction = DOWN
			elif event.is_action_pressed("ui_up"):
				direction = UP
				
			print("direction from controls = ", direction)
			
			emit_signal('start_game', direction)
			
			set_process_input(false)
	
func fade_out():
	$AnimationPlayer.play('fadeout')
	
	yield($AnimationPlayer, 'animation_finished')
	
	hide()
