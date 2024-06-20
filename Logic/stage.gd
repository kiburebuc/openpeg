extends Node2D

@export var scoreToFreeBall1 = 15000
@export var scoreToFreeBall2 = 75000
@export var scoreToFreeBall3 = 125000
var ball1granted = false
var ball2granted = false
var ball3granted = false

var ballCount = 10
var orangeCount = 25
var rawScore = 0
var pegsHitMult = 0
var fevermeterMult = 1
var ballInPlay = false
var lost = false


#handle clicking
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if not ballInPlay and not lost:
			$Ball.move_body($BallJector.position, Vector2.RIGHT.rotated($BallJector.rotation) * $BallJector.shootVelocity)
			ballInPlay = true
			ballCount -= 1
			$"Stage Elements".setBallsLeft(ballCount)


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Stage Elements".resetBalloTron()
	$"Stage Elements".setBallsLeft(ballCount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#called when ball hits deathPit
func resetGame():
	#print("game reset")
	$Ball.set_deferred("freeze", true)

	rawScore = 0
	pegsHitMult = 0
	$"Stage Elements".resetBalloTron()
	
	if await $"Peg Controller".resetBoard():
		ballCount += 1
	
	ballInPlay = false

	if ballCount == 0:
		$Message.text = "You Lost!"
		lost = true


func pegHit(val, isOrange):
	pegsHitMult += 1
	rawScore += val
	if isOrange:
		orangeCount -= 1

	if orangeCount <= 3:
		fevermeterMult = 10
		print("mult = " + str(fevermeterMult))
	elif orangeCount <= 6:
		fevermeterMult = 5
		print("mult = " + str(fevermeterMult))
	elif orangeCount <= 10:
		fevermeterMult = 3
		print("mult = " + str(fevermeterMult))
	elif orangeCount <= 15:
		fevermeterMult = 2
		print("mult = " + str(fevermeterMult))
	
	var totalScore = pegsHitMult * rawScore * fevermeterMult
	
	$"Stage Elements".setScore(totalScore)
	$"Stage Elements".setOrangesLeft(orangeCount)
	
	if (totalScore) >= scoreToFreeBall1 and not ball1granted:
		ballCount += 1
		$"Stage Elements".setBallsLeft(ballCount)
		ball1granted = true
	if (totalScore) >= scoreToFreeBall2 and not ball2granted:
		ballCount += 1
		$"Stage Elements".setBallsLeft(ballCount)
		ball2granted = true
	if (totalScore) >= scoreToFreeBall3 and not ball3granted:
		ballCount += 1
		$"Stage Elements".setBallsLeft(ballCount)
		ball3granted = true
	print(rawScore, "*", pegsHitMult, "*", fevermeterMult, "=", totalScore)


func setMessage(val):
	$Message.text = val

func hitOrange():
	orangeCount -= 1
	$"Stage Elements".setOrangesLeft(orangeCount)

func freeBallBucketHit():
	ballCount += 1
	$"Stage Elements".setBallsLeft(ballCount)
