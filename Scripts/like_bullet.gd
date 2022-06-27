extends Area2D

const SPEED = 200
var velocity = Vector2()
var direction = 1





func _ready():
	pass # Replace with function body.

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	
	


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_like_projectile_body_entered(body):
	queue_free()
