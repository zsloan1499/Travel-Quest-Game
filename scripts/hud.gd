extends CanvasLayer


var quest_status = "Inactive"


func _process(delta):
	update_armor_hud()
	update_hud()

func update_hud():
	$Gold.text = "Gold: " + str(Global.gold)
	$Potions.text = "Potions Left: " + str(Global.potion)
	if Quest.status == 0:
		quest_status = "Inactive"
	elif Quest.status == 1: 
		quest_status = "Active"
	elif Quest.status == 2: 
		quest_status = "Complete"
	$QuestStatus.text = "Quest Status: " + str(quest_status)
	if Quest.status == 0: 
		$QuestGoal.text = "Quest Goal: None"
	elif Quest.selected_quest == "KillSlime1":
		$QuestGoal.text = "Quest Goal: Kill " + str(Quest.slime_objective) + " " +  str(Quest.enemy)
	elif Quest.selected_quest == "KillSlime2":
		$QuestGoal.text = "Quest Goal: Kill " + str(Quest.slime_objective) + " " + str(Quest.enemy)
	elif Quest.selected_quest == "KillSlime3":
		$QuestGoal.text = "Quest Goal: Kill " + str(Quest.slime_objective) + " " + str(Quest.enemy)
	elif Quest.selected_quest == "KillGoblin1":
		$QuestGoal.text = "Quest Goal: Kill " + str(Quest.goblin_objective) + " " + str(Quest.enemy)
	$Metal.text = "Metal Fragments: " + str(Global.metal_fragments)

func update_armor_hud():
	
	#boots armor
	if Global.boots == true:
		$Boots1.visible = true
	else:
		$Boots1.visible = false
	if Global.upgraded_boots == true:
		$Boots2.visible = true
		$Boots1.visible = false
	else:
		$Boots2.visible = false
		
	#Chest armor
	if Global.chest == true:
		$Chest1.visible = true
	else:
		$Chest1.visible = false
	if Global.upgraded_chest == true:
		$Chest2.visible = true
		$Chest1.visible = false
	else:
		$Chest2.visible = false
		
	#helmet armor
	if Global.helmet == true:
		$Helmet1.visible = true
	else:
		$Helmet1.visible = false
	if Global.upgraded_helmet == true:
		$Helmet2.visible = true
		$Helmet1.visible = false
	else:
		$Helmet2.visible = false
