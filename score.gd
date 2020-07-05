extends Control

onready var counterLabel = $ScoreCounter
onready var shoutLabelContainer = $CenterContainer/Control
onready var shoutLabel = $CenterContainer/Control/ScoreShout
onready var shoutTween = $CenterContainer/Control/Tween

var playerRef : Node2D

func _ready():
	hide()
	shoutLabelContainer.hide()
	playerRef = get_tree().get_nodes_in_group('player').front()

func reset():
	show()
	shoutLabelContainer.hide()
	counterLabel.text = str(0)


func set_counter(text):
	shoutLabelContainer.rect_scale = Vector2(0.1, 0.1)
	shoutLabelContainer.show()
	shoutLabel.text = str(text)
	
	shoutTween.interpolate_property(shoutLabelContainer, "rect_scale", shoutLabelContainer.rect_scale, Vector2(2.0, 2.0), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	shoutTween.interpolate_property(shoutLabelContainer, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	shoutTween.start()
	
	yield(shoutTween, 'tween_completed')
	
	shoutLabelContainer.hide()
	
	counterLabel.text = str(text)
