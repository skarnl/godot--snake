extends Node2D


onready var game_over_screen = $HUD/GameOverScreen

var snapePartInstance = preload("res://SnakePart.tscn")
var snake_parts = []
var screen_size = Vector2.ZERO


func _ready():
	screen_size = get_viewport().size
	$Snake.connect("moved", self, "_on_Snake_moved")
	
	
	$CandySpawner.connect("candy_eaten", self, "on_Candy_candy_eaten")
	$CandySpawner.start(screen_size)
	
	reset()
	
	

func on_Candy_candy_eaten():
	print("main::on candy eaten")
	
	var new_snake_part = snapePartInstance.instance()
	new_snake_part.set_precursor(snake_parts.back())
	snake_parts.append(new_snake_part)
	
	$SnakeParts.add_child(new_snake_part)


func _trigger_game_over():
	get_tree().paused = true
	
	game_over_screen.show_game_over()
	
	yield(get_tree().create_timer(5.0), "timeout")
	
	reset()


func _on_Snake_moved(previous_position):
	var head = snake_parts.front()
	
	for i in range(1, snake_parts.size()):
		var part = snake_parts[i]
		
		if head.position == part.position:
			_trigger_game_over()
			break


func reset():
	for i in range(1, snake_parts.size()):
		var part = snake_parts[i]
		part.destroy()
	
	snake_parts = []
	snake_parts.append($Snake)
	$Snake.position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
	game_over_screen.reset()
	
	get_tree().paused = false
