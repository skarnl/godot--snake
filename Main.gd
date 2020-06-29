extends Node2D


var snapePartInstance = preload("res://SnakePart.tscn")
var snake_parts = []


func _ready():
	snake_parts.append($Snake)
	$Snake.connect("moved", self, "_on_Snake_moved")
	$CandySpawner.connect("candy_eaten", self, "on_Candy_candy_eaten")
	$CandySpawner.start()

	

func on_Candy_candy_eaten():
	print("main::on candy eaten")
	
	var new_snake_part = snapePartInstance.instance()
	new_snake_part.set_precursor(snake_parts.back())
	snake_parts.append(new_snake_part)
	
	$SnakeParts.add_child(new_snake_part)


func _trigger_game_over():
	get_tree().paused = true
	
	$CanvasLayer/GameOverScreen.show_game_over()
	
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
	$Snake.position = Vector2(512, 256)
	
	$CanvasLayer/GameOverScreen.reset()
	
	get_tree().paused = false
