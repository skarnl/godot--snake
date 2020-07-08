extends Node2D


onready var game_over_screen = $HUD/GameOverScreen
onready var main_menu = $HUD/MainMenu
onready var score = $HUD/Score

var snapePartInstance = preload("res://entities/SnakePart.tscn")
var snake_parts = []
var screen_size = Vector2.ZERO
var candies_eaten = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	screen_size = get_viewport().size
	$Snake.connect("moved", self, "_on_Snake_moved")
	$HUD/Controls.hide()
	
	$CandySpawner.connect("candy_eaten", self, "on_Candy_candy_eaten")
	
	main_menu.connect("start_game", self, "_on_MainMenu_start_game")
	
	$bottom.connect('body_entered', self, '_on_offscreen')
	$top.connect('body_entered', self, '_on_offscreen')
	$left.connect('body_entered', self, '_on_offscreen')
	$right.connect('body_entered', self, '_on_offscreen')
	
	$HUD/Controls.connect('start_game', self, '_on_Controls_start_game')
	
	reset()
	main_menu.show_menu()
	
	get_tree().paused = true

func _on_offscreen(_body):
	_trigger_game_over()

func on_Candy_candy_eaten():
	print("main::on candy eaten")
	
	$Snake.play_eating_sound()
	
	var new_snake_part = snapePartInstance.instance()
	new_snake_part.set_precursor(snake_parts.back())
	new_snake_part.connect('hit_head', self, '_on_hit_head')
	snake_parts.append(new_snake_part)
	$SnakeParts.add_child(new_snake_part)
	
	candies_eaten += 1
	$HUD/Score.set_counter(candies_eaten)
	
	$Snake.increase_speed()


func _on_hit_head():
	_trigger_game_over()


func _trigger_game_over():
	get_tree().paused = true
	
	game_over_screen.show_game_over()
	
	$CandySpawner.stop()
	
	yield(get_tree().create_timer(5.0), "timeout")
	
	$Snake.pause_mode = Node.PAUSE_MODE_PROCESS
	$Snake.reset()
	yield(get_tree(), 'idle_frame')
	$Snake.pause_mode = Node.PAUSE_MODE_STOP
	
	reset()
	main_menu.show_menu()


func _on_MainMenu_start_game():
	main_menu.hide()
	
	$HUD/Controls.show()
	

func _on_Controls_start_game(direction):
	$HUD/Controls.fade_out()
	
	start()
	
	$Snake.start(direction)
	

func reset():
	for i in range(1, snake_parts.size()):
		var part = snake_parts[i]
		part.destroy()
	
	snake_parts = []
	snake_parts.append($Snake)
	
	game_over_screen.reset()
	
	score.reset()
	
	candies_eaten = 0
	$HUD/Score.reset()


func start():
	$CandySpawner.start(screen_size)
	get_tree().paused = false
