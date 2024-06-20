extends Area2D

@export var leftBound = 526
@export var rightBound = 1396
var speed = 300
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time sinmaxce the previous frame.
func _process(delta):
	speed = min(position.x - leftBound + 100, rightBound - position.x + 100)
	if position.x <= leftBound or position.x >= rightBound:
		direction = -direction
	position.x += direction * speed * delta


func _on_area_entered(area):
	if "Ball" in area.name:
		$"../..".setMessage("Free Ball!")
		$"../..".freeBallBucketHit()
		area.touchedPeg = true
