extends CanvasLayer

onready var player = get_parent().get_node("Player")
onready var healthBar = $Health

var has_died = false


func _process(delta):
	
	if !has_died:
		if player.health == 10 :
			healthBar.value = 100
			healthBar.tint_progress = Color.chartreuse
		
	
		elif player.health == 8 :
			healthBar.value = 65
		
		elif player.health == 6 :
			healthBar.value = 53
			healthBar.tint_progress = Color.yellow
		elif player.health == 4 :
			healthBar.value = 41
			healthBar.tint_progress = Color.orange
		elif player.health == 2 :
			healthBar.value = 27
			healthBar.tint_progress = Color.red
	
		elif player.health == 1:
			healthBar.value = 0
			has_died = true
