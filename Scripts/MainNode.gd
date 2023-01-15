extends Node2D
var player_input_x
var player_input_y
var txt = ""
var DEBUG_HUD = true
	
# Charge la scene de l'item
onready var item = preload("res://Scenes/item.tscn")
onready var screen = get_viewport().size

func _ready():
	SpawnItem(5)

func _process(delta):
	player_input_x = $Player.dirX
	player_input_y = $Player.dirY
	debug_print()


func SpawnItem(nb_items):
	randomize()
	for x in nb_items:
		var x_pose = rand_range(-screen.x/2,screen.x/2)
		var y_pose = rand_range(-screen.y/2,screen.y/2)
		var type = randi() % 3
		print(type)
		var i = item.instance() # cree instance de item
		i.InitializeItem(Vector2(x_pose,y_pose),type)
		self.add_child(i) #ajoute enfant :i: à self

##################################

func debug_print():
	txt = """DEBUG LABEL
	Player input: 		{} , {}
	Player position: 	{} , {}
	Slider:				{}
	Rotating angle: 	{} °
	
	------ Screen -----
	Size = {}
	x = {}
	y = {}
	
	------ Kinetic Ball -----
	Position: 			{}
	Speed: 				{} px/s
	Bounce:				{}
	Damp:				{}
	friction:			{}
	""".format([
		player_input_x,player_input_y,
		$Player.position.x,$Player.position.y,
		$SpeedSlider.value,
		$Player/Shell.angle,
		
		screen,
		screen.x,
		screen.y,
		
		$Kineticball.position,
		$Kineticball.linear_velocity.length(),
		$Kineticball.bounce,
		$Kineticball.linear_damp,
		$Kineticball.friction
		],"{}")
	if DEBUG_HUD: $Camera2D/DebugHUD.text = txt
	else: 		  $Camera2D/DebugHUD.text = ""

func InitialPose_button():
	$Player.position.x = 0
	$Player.position.y = 0

func Debug_pressed():
	DEBUG_HUD = not DEBUG_HUD

func SpawnItem_pressed():
	SpawnItem(5)
