extends Node2D

signal candy_eaten

var random = RandomNumberGenerator.new()
var candyItem = preload("res://Candy.tscn")

const X_MAX = 1024
const Y_MAX = 608
const CELL_SIZE = 32

func start():
	random.randomize()
	_spawn_candy()


func _spawn_candy():
	var candy = candyItem.instance()
	candy.connect("eaten", self, "_on_Candy_eaten", [candy])
	candy.connect("rotten", self, "_on_Candy_rotten", [candy])
	
	var xpos: int = random.randi_range(CELL_SIZE, X_MAX - CELL_SIZE)
	var ypos: int = random.randi_range(CELL_SIZE, Y_MAX - CELL_SIZE)
	
	print(xpos)
	print(ypos)
	
	candy.position = Vector2(xpos, ypos)
	
	add_child(candy)


func _on_Candy_eaten(candy):
	print("candy spawner:: eaten")
	
	emit_signal("candy_eaten")
	
	_handle_candy_gone()


func _on_Candy_rotten(candy):
	print("candy spawner:: rotten")
	
	_handle_candy_gone()
	
	
func _handle_candy_gone():
#	candy.disconnect("eaten", self, "_on_Candy_eaten", [candy])
#	candy.disconnect("rotten", self, "_on_Candy_rotten", [candy])
	
	_spawn_candy()
