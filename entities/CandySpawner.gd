extends Node2D

signal candy_eaten

var random = RandomNumberGenerator.new()
var candyItem = preload("res://entities/Candy.tscn")

const CELL_SIZE = 32

var _screen_size : Vector2

var spawn_candy = true

func start(screen_size):
	reset()
	random.randomize()
	
	_screen_size = screen_size
	
	_spawn_candy()


func _spawn_candy():
	if not spawn_candy:
		return
	
	var candy = candyItem.instance()
	candy.connect("eaten", self, "_on_Candy_eaten", [candy])
	candy.connect("rotten", self, "_on_Candy_rotten", [candy])
	
	var xpos: int = random.randi_range(CELL_SIZE, _screen_size.x  - CELL_SIZE)
	var ypos: int = random.randi_range(CELL_SIZE, _screen_size.y - CELL_SIZE)
	
	candy.position = Vector2(xpos, ypos)
	
	add_child(candy)


func stop():
	spawn_candy = false


func _on_Candy_eaten(candy):
	print("candy spawner:: eaten")
	
	emit_signal("candy_eaten")
	
	_handle_candy_gone()


func _on_Candy_rotten(candy):
	print("candy spawner:: rotten")
	
	_handle_candy_gone()
	
	
func _handle_candy_gone():
	_spawn_candy()


func reset():
	for child in get_children():
		child.queue_free()
	
	spawn_candy = true
