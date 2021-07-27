extends KinematicBody2D

const GRAVITY = 10
const MOVESPEED = 100
const JUMPFORCE = 200
const MAXFALLSPEED = 200

var BULLET = preload("res://bullet_scenes/like_bullet.tscn")

var UP = Vector2(0, -1)

var health = 10

var motion = Vector2.ZERO

var on_ground = false

onready var animation = get_node("AnimatedSprite")




func _process(delta):
		
	if Input.is_action_pressed("right"):
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("left"):
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
		
	if Input.is_action_just_pressed("shoot"):
		var like = BULLET.instance()
		if sign($Position2D.position.x) == 1:
			like.set_bullet_direction(1)
		else:
			like.set_bullet_direction(-1)
			
		get_parent().add_child(like)
		like.position = $Position2D.global_position
		
		



func _physics_process(delta):
	

	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED

	
	#Character movement and animation
	if Input.is_action_pressed("right"):
		motion.x = MOVESPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		on_ground = true
	
	elif Input.is_action_pressed("left"):
		motion.x = -MOVESPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		on_ground = true
	else:
		motion.x = 0
		
		if is_on_floor() and on_ground:
			$AnimatedSprite.play("idle")

	if Input.is_action_just_pressed("jump"):
		motion.y = -JUMPFORCE
		on_ground = false
		
	# Check if the player is on floor
	# Else make jump animation and fall animation
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if motion.y < 0:
			$AnimatedSprite.play("jump")
			on_ground = false
		elif !on_ground:
			$AnimatedSprite.play("falling")
	
	
	# Weapon changing animation and instantiating the correct bullet
	if Input.is_action_just_pressed("like"):
		BULLET = preload("res://bullet_scenes/like_bullet.tscn")
		
		$Bullets.play("like")
		
		
			
	if Input.is_action_just_pressed("heart"):
		BULLET = preload("res://bullet_scenes/heart_bullet.tscn")
		$Bullets.play("heart")
	
	if Input.is_action_just_pressed("fire"):
		BULLET = preload("res://bullet_scenes/fire_bullet.tscn")
		$Bullets.play("fire")
		

	
		
		
	
	move_and_slide(motion, UP)
	
# Enemy kills the player part
func _on_area_hit_area_entered(area):
	if(area.name == "area_bullet"):
		area.get_parent().queue_free()
		
		health -= 1
		Globals.camera.shake(60, 0.3, 200)
	print(health)
	if health == 0:
		queue_free()
	
#New code pushed to git

func _on_Timer_timeout():
	$Bullets.play("transparent")
