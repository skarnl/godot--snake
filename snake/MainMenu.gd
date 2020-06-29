extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	
	$Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_mouse_entered():
	$Button/Sprite.play()


func _on_Button_mouse_exited():
	$Button/Sprite.stop()


func _on_Button_pressed():
	emit_signal("start_game")
	hide()
