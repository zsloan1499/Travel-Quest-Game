class_name quest
extends Node

enum QuestStatus {INACTIVE,ACTIVE,COMPLETED}


var status = QuestStatus.INACTIVE
var quest_array = ["KillSlime1","KillSlime2", "KillSlime3","KillGoblin1"]


var random_index = randi() % quest_array.size()
var selected_quest = quest_array[random_index]
var slime_objective = 0
var goblin_objective = 0

var enemy_array = ["Slime(s)","Goblin(s)"]
var enemy: String

var required_kills = {
	"KillSlime1": 1,
	"KillSlime2": 2,
	"KillSlime3": 3,
	"KillGoblin1": 1
}
var quest_goal: String

func reset():
	status = Quest.QuestStatus.INACTIVE

func give_quest():
	if not quest_array.is_empty():
		if status == QuestStatus.INACTIVE:
			var random_index = randi() % quest_array.size()
			selected_quest = quest_array[random_index]
			if random_index > 2:
				enemy = enemy_array[1]
			else:
				enemy = enemy_array[0]
			print("Quest activated:", selected_quest)
			# Set the quest status to ACTIVE
			status = QuestStatus.ACTIVE
			if random_index <= 2:
				slime_objective = required_kills[selected_quest]
			else:
				goblin_objective = required_kills[selected_quest]
		
func update_progress():
	if status == QuestStatus.ACTIVE:
		# Check quest progress and update status accordingly
		slime_objective = slime_objective - 1
		goblin_objective = goblin_objective - 1
		if slime_objective <= 0:
			status = QuestStatus.COMPLETED
			print("Quest completed!")
			if selected_quest == "KillSlime1":
				Global.gold = Global.gold + 2
				print("2 gold added")
				print(selected_quest)
			if selected_quest == "KillSlime2":
				Global.gold = Global.gold + 3
				print("3 gold added")
				print(selected_quest)
			if selected_quest == "KillSlime3":
				Global.gold = Global.gold + 5
				print("5 gold added")
				print(selected_quest)
		elif goblin_objective <= 0:
			if selected_quest == "KillGoblin1":
				Global.gold = Global.gold + 4
				print("4 gold added")
				print(selected_quest)
			else:
				print("random gold")
		else:
			print("Quest progress:", slime_objective, "enemy(s) remaining")
