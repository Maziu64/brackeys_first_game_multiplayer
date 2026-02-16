extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if not MultiplayerManager.multiplayer_mode_enabled:
		print("You died!!")
		#Baja la veocidad a la que corre el engine, para dar un efecto de muerte
		Engine.time_scale = 0.5 
		body.get_node("CollisionShape2D").queue_free()
		timer.start()
	else:
		_multiplayer_dead(body)

func _multiplayer_dead(body):
	if multiplayer.is_server() && body.alive:
		Engine.time_scale = 0.5
		body.mark_dead()

func _on_timer_timeout() -> void:
	Engine.time_scale = 0.5
	get_tree().reload_current_scene()
