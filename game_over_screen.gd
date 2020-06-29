extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func show_game_over():
	show()
	
	$AnimationPlayer.play('show')
	

func reset():
	hide()
	
	$AnimationPlayer.stop(true)
