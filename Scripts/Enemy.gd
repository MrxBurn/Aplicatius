extends KinematicBody2D

onready var BULLET_SCENE = preload("res://Bullet.tscn")

var player = null
var move = Vector2.ZERO
var speed = 1

var health = 3


func _physics_process(delta):
	move = Vector2.ZERO
	
	$AnimatedSprite.play("roam")
	
	if player != null:
		
		move.x = position.direction_to(player.position).x * speed
	else:
		move = Vector2.ZERO
	
	if move.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	
	move = move.normalized()
	move_and_collide(move)

func _on_Area2D_body_entered(body):
	if body != self:
		player = body


func _on_Area2D_body_exited(body):
	player = null


func _on_Timer_timeout():
	if player != null:
		fire()
	
	
func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position();
	bullet.player = player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(0.5)
	
	
func _on_CheckBullet_area_entered(area):
	if(area.name == "fire_projectile"):
		health -= 1
	if health == 0:
		queue_free()
		

