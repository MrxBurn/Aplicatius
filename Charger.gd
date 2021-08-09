extends KinematicBody2D


# Get player's health
# If the player collides with the charger => restore his health
const HEAL = 10


onready var player = get_parent().get_node("Player")


func _physics_process(delta):
	$AnimatedSprite.play("idle")
	


func _on_Area2D_body_entered(body):
	player.health = HEAL
	
