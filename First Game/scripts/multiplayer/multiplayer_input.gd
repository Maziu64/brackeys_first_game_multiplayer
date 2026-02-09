extends MultiplayerSynchronizer

var input_direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	prueba()
	#Aqui hacemos que si no se posee el id del peer de esta maquina, se inhabilitan proccess y physisc proccess
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	input_direction = Input.get_axis("move_left", "move_right")

func _physics_process(delta: float) -> void:
	input_direction = Input.get_axis("move_left", "move_right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func prueba():
	var prueba = multiplayer.get_unique_id()
	print(str(get_multiplayer_authority()))
	print(str(prueba))
