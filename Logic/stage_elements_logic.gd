extends Node2D 



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func resetBalloTron():
	$"BalloTron Meter Green".set_value(0)
	$"BalloTron Meter Purple".set_value(0)
	$"BalloTron Meter Gold".set_value(0)

func setScore(val):
	$"BalloTron Meter Green".set_value(val)
	$"BalloTron Meter Purple".set_value(val)
	$"BalloTron Meter Gold".set_value(val)

func setOrangesLeft(val):
	$"Fevermeter Bar".set_value(25 - val)

func setBallsLeft(val):
	$"BallCounter".text = "[center]" + str(val)
