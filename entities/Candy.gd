extends Sprite

signal eaten
signal rotten

# Called when the node enters the scene tree for the first time.
func _ready():
	$KinematicBody2D.connect('body_entered', self, "_on_KinematicBody_body_entered")
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _on_KinematicBody_body_entered(_body):
	$KinematicBody2D.disconnect('body_entered', self, "_on_KinematicBody_body_entered")
	emit_signal("eaten")
	
	$AnimationPlayer.play("eaten")
	
	yield($AnimationPlayer, "animation_finished")
	
	queue_free()


func _on_Timer_timeout():
	emit_signal("rotten")
	queue_free()
