extends StaticBody2D

enum PegColor {Blue, Orange, Green, Purple}

var color = PegColor.Blue
var activated = false
var fastDelete = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func activate():
	if not activated:
		$PegHit.play()
		
		if fastDelete:
			$DeleteTimer.start()
		
		var baseScore = 0
		
		match color:
			PegColor.Blue:
				$Sprite2D.texture = preload("res://Textures/Pegs/HDbluePegAct.png")
				baseScore = 10
			
			PegColor.Orange:
				$Sprite2D.texture = preload("res://Textures/Pegs/HDorangePegAct.png")
				baseScore = 100
			
			PegColor.Green:
				$Sprite2D.texture = preload("res://Textures/Pegs/HDgreenPegAct.png")
				baseScore = 10
			
			PegColor.Purple:
				$Sprite2D.texture = preload("res://Textures/Pegs/HDpurplePegAct.png")
				baseScore = 500
		
		$"..".iGotHit(baseScore, self)
		activated = true
		
		#display score below peg for 1 sec
		$ScoreLabel.text = "[center]" + str(baseScore)
		await get_tree().create_timer(1).timeout
		$ScoreLabel.text = ""

#when fastDelete timers out, delete peg
func _on_delete_timer_timeout():
	#print("timer out!, disappearing!")
	queue_free()

func makeBlue():
	$Sprite2D.texture = preload("res://Textures/Pegs/HDbluePeg.png")
	color = PegColor.Blue

func makeOrange():
	$Sprite2D.texture = preload("res://Textures/Pegs/HDorangePeg.png")
	color = PegColor.Orange
	
func makeGreen():
	$Sprite2D.texture = preload("res://Textures/Pegs/HDgreenPeg.png")
	color = PegColor.Green
	
func makePurple():
	$Sprite2D.texture = preload("res://Textures/Pegs/HDpurplePeg.png")
	color = PegColor.Purple
