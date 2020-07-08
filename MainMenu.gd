extends Control

signal start_game

func show_menu():
	$Button.grab_focus()
	show()


func _on_Button_mouse_entered():
	$Button/Sprite.play()


func _on_Button_mouse_exited():
	$Button/Sprite.stop()


func _on_Button_pressed():
	emit_signal("start_game")
	hide()
