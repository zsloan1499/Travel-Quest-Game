extends Node

var first_load = true
var previous_scene = ""
var current_scene = ""
var gold = 0
var potion = 0
var health = 100
var boots = false
var upgraded_boots = false
var helmet = false
var upgraded_helmet = false
var chest = false
var upgraded_chest = false
var boots_chest_open = false
var chest_chest_open = false
var helmet_chest_open = false
var player_damage = 1
var goblin_attacking = false
var metal_fragments = 100

func reset():
	first_load = true
	previous_scene = ""
	current_scene = ""
	gold = 0
	potion = 0
	health = 100
	boots = false
	upgraded_boots = false
	helmet = false
	upgraded_helmet = false
	chest = false
	upgraded_chest = false
	boots_chest_open = false
	chest_chest_open = false
	player_damage = 1
	goblin_attacking = false
	metal_fragments = 0
	print("reset")

func update_boots():
	if boots == false:
		boots = true
	if upgraded_boots == true:
		boots = false


func update_helmet():
	if helmet == false:
		helmet = true
		player_damage = 1.5
	if upgraded_helmet == true:
		helmet = false
		player_damage = 2

func update_chest():
	if chest == false:
		chest = true
	if upgraded_chest == true:
		chest = false

