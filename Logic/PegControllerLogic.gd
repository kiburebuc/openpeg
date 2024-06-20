extends Node2D

var totalPegs = 0
var orangeCount = 25
var pegsHit = Array()

# On start, generate and setup pegs
func _ready():
	#generate peg layout
	var genPeg = load("res://Objects/genericPeg.tscn")
	var pegPos = Vector2(616, 405) #first peg coords
	
	#8 rows of 12 pegs
	for y in 8:
		for x in 12:
			var newPeg = genPeg.instantiate()
			newPeg.set_name("Peg " + str(totalPegs))
			add_child(newPeg)
			totalPegs += 1
			newPeg.position = pegPos
			pegPos.x += 65
		pegPos.x = (616 if y%2 != 0 else 586)
		pegPos.y += 65
	
	#make some pegs orange and green
	generateColoredPegsOnStart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# On startup, make some pegs orange, and some green
func generateColoredPegsOnStart():
	var oranges = orangeCount
	while oranges != 0:
		var ind = randi_range(0, get_child_count() - 1) #randomly choose peg
		if "Peg" in get_child(ind).name and get_child(ind).color == 0:
			#print("Making ", get_child(ind).name, " orange")
			get_child(ind).makeOrange()
			oranges -= 1
	
	var greens = 2
	while greens != 0:
		var ind = randi_range(0, get_child_count() - 1) #randomly choose peg
		if "Peg" in get_child(ind).name and get_child(ind).color == 0:
			#print("Making ", get_child(ind).name, " green")
			get_child(ind).makeGreen()
			greens -= 1
	
	var purple = 1
	while purple != 0:
		var ind = randi_range(0, get_child_count() - 1) #randomly choose peg
		if "Peg" in get_child(ind).name and get_child(ind).color == 0:
			#print("Making ", get_child(ind).name, " green")
			get_child(ind).makePurple()
			purple -= 1

#Called by child peg when it gets hit
func iGotHit(baseScore, peg):
	$"..".pegHit(baseScore, peg.color == 1)
	pegsHit.append(peg)
	
func resetBoard() -> bool:
	var hitPegs = pegsHit.is_empty()

	for i in pegsHit:
		i._on_delete_timer_timeout()
		await get_tree().create_timer(0.1).timeout
	pegsHit.clear()
	
	return hitPegs
