extends RigidBody2D

var resetState = false
var moveVector: Vector2
var linearVelocityVector: Vector2

var touchedPeg = false

func _integrate_forces(state):
	if resetState:
		state.transform = Transform2D(0.0, moveVector)
		state.linear_velocity = linearVelocityVector
		resetState = false


func move_body(targetPos: Vector2, targetVelocity: Vector2):
	print("moving")
	moveVector = targetPos
	linearVelocityVector = targetVelocity
	resetState = true
	set_deferred("freeze", false)
	touchedPeg = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_deferred("freeze", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass 
	#print(position)

#when ball touches something, do something
func _ball_interaction(body):
	if "DeathPit" in body.name:
		get_parent().resetGame()
	
	if "Peg" in body.name:
		touchedPeg = true
		body.activate()
