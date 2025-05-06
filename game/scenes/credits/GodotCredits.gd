extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
@export var title_color : Color = Color.BLUE_VIOLET

var scroll_speed := base_speed
var speed_up : bool = false

@onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"Anima",
		"a game by literally a single person",
		"and one of his friend's afternoons"
		
	],[
		"Programming",
		"Sidney Cha"
	],[
		"Art",
		"Sidney Cha",
		"Phteven"
	],[
		"Music",
		"Sidney Cha"
	],[
		"Sound Effects",
		"Spell Sounds Starter Pack by p0ss"
	],[
		"Other Assets",
		"Abaddon Pixel Font by Abbadon",
		"Pixel Effects by BDragon1727",
		"Input Prompts by Kenney",
		"Dungeon Gathering Tileset by Snowhex"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
	],[
		"Licenses",
		"No permission to use or distribute this game is given beyond the scope of the class it was assigned for",
		"re-use of any code, assets, or other content is strictly prohibited without the expressed permission of the author",
		"and the original authors of any assets used"
	],[
		"Special thanks",
		"to the rat who bailed and hid behind the skirts of his friends",
		"I now refuse to work with you in any professional capacity",
		"in all current and future projects"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.position.y -= scroll_speed
			if l.position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene_to_file("res://game/scenes/title/titleScreen.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_theme_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
