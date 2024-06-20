extends Node2D

const shootVelocity = 700

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace wNode2Dith function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation = find_angle() - PI
	
	$"../BallPath".clear_points()
	
	for i in range(0, 10):
		$"../BallPath".add_point(calc_path(i * 0.05))

func calc_path(t) -> Vector2:
	var x = shootVelocity * t * cos(rotation)
	var y = shootVelocity * t * sin(rotation) + (0.5 * 980 * t * t)
	
	return Vector2(x, y) + position #transform func to origin of balljector


#from https://www.forrestthewoods.com/blog/solving_ballistic_trajectories/
func find_angle() -> float:
	var diff = position - get_global_mouse_position()
	
	var speed2 = shootVelocity * shootVelocity
	var speed4 = speed2 * speed2
	
	var root = speed4 - 980 * (980 * diff.x * diff.x + 2 * diff.y * speed2);
	
	if root < 0:
		#print("No Solution")
		return 0
	
	root = sqrt(root)
	return atan2(speed2 - root, 980 * diff.x)
