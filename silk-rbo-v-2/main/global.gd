extends Node

# Seed and rng
var rng = RandomNumberGenerator.new()

# Every array needed and selection
var possibleBossList = []
var randomBossList = ["Moss Mother 1"]
var currentSelection: String = ""
var generateBossList: bool = false
var lowerDocksFirst: bool = false
var moorwingOriginal: bool = false

# Other settings bools
var generateAllOrNot: bool = true
var doubleGMS: bool = false
var blackThreads: bool = true
var actOneLimiter: bool = false
var actTwoLimiter: bool = false

# Counters for other reqs
var khannCounter: int = 0
var karmelitaCounter: int = 0
var nylethCounter: int = 0
var cloverCounter: int = 0
var everbloomCounter: int = 0

# Every other requirements variable storage
var swiftStep: bool = false
var driftersCloak: bool = false
var clingGrip: bool = false
var needolin: bool = false
var clawline: bool = false
var faydownCloak: bool = false
var silkSoar: bool = false
var elegyDeep: bool = false
var everbloom: bool = false
var blackThreadsBool: bool = false
var silkAndSoul: bool = false
var actTwo: bool = false
var actThree: bool = false

# Variable storage for bosses already in randomBossList
var mossMotherOne: bool = false
var bellBeast: bool = false
var laceOne: bool = false
var fourthChorus: bool = false
var savageBeastflyOne: bool = false
var moorwing: bool = false
var sisterSplinter: bool = false
var skullTyrant: bool = false
var widow: bool = false
var mossMotherTwo: bool = false
var greatConchflies: bool = false
var lastJudge: bool = false
var phantom: bool = false
var savageBeastflyTwo: bool = false
var cogworkDancers: bool = false
var trobbio: bool = false
var garmondAndZaza: bool = false
var forebrothers: bool = false
var unravelled: bool = false
var lugoli: bool = false
var fatherFlame: bool = false
var voltvyrm: bool = false
var ragingConchfly: bool = false
var secondSentinel: bool = false
var groal: bool = false
var shakra: bool = false
var broodmother: bool = false
var firstSinner: bool = false
var laceTwo: bool = false
var grandMotherSilk: bool = false
var bellEater: bool = false
var lostGarmond: bool = false
var plasmifiedZango: bool = false
var pinstress: bool = false
var tormentedTrobbio: bool = false
var watcherEdge: bool = false
var crawfather: bool = false
var khann: bool = false
var karmelita: bool = false
var gurr: bool = false
var seth: bool = false
var nyleth: bool = false
var palestag: bool = false
var cloverDancers: bool = false
var lostLace: bool = false

# Chooses the next random boss out of the current potentialBossList
func chooseRandomNext():
	# Gets the possible next boss as a safety net
	getPossibleNext()
	# If there is a next possible boss it picks random and sets it to a variable for more use
	if not possibleBossList.is_empty():
		currentSelection = possibleBossList[rng.randi_range(0, possibleBossList.size() - 1)]
	# Appends the randomly picked boss from possibleBossList and removes it from said list
	if currentSelection != "":
		randomBossList.append(currentSelection)
		possibleBossList.erase(currentSelection)
	# Resets currentSelection so you can't continously add the same boss
	currentSelection = ""

func randomizeFullList():
	generateBossList = true
	while(generateBossList):
		chooseRandomNext()
		getPossibleNext()
		if possibleBossList.is_empty():
			generateBossList = false

# Gets all bosses currently possible with the bosses already in the randomBossList
func getPossibleNext():
	# Makes absolute sure getBossesDefeated has been ran
	getBossesDefeated()
	# Makes sure the other reqs are updated
	checkOtherReqs()
	checkOtherReqs()
	# The logic for all bosses in order
	if bellBeast == false && not possibleBossList.has("Bell Beast"):
		possibleBossList.append("Bell Beast")
	if (swiftStep) && laceOne == false && not possibleBossList.has("Lace 1"):
		possibleBossList.append("Lace 1")
	if (laceOne) && fourthChorus == false && not possibleBossList.has("Fourth Chorus"):
		possibleBossList.append("Fourth Chorus")
	if (driftersCloak) && savageBeastflyOne == false && not possibleBossList.has("Savage Beastfly 1"):
		possibleBossList.append("Savage Beastfly 1")
	if (lastJudge) && moorwing == false && not possibleBossList.has("Moorwing"):
		possibleBossList.append("Moorwing")
	if (swiftStep) && sisterSplinter == false && not possibleBossList.has("Sister Splinter"):
		possibleBossList.append("Sister Splinter")
	if (sisterSplinter) && skullTyrant == false && not possibleBossList.has("Skull Tyrant"):
		possibleBossList.append("Skull Tyrant")
	if (clingGrip) && widow == false && not possibleBossList.has("Widow"):
		possibleBossList.append("Widow")
	if (needolin) && mossMotherTwo == false && not possibleBossList.has("Moss Mother 2"):
		possibleBossList.append("Moss Mother 2")
	if (clingGrip) && greatConchflies == false && not possibleBossList.has("Great Conchflies"):
		possibleBossList.append("Great Conchflies")
	if (laceOne && needolin) && lastJudge == false && not possibleBossList.has("Last Judge"):
		possibleBossList.append("Last Judge")
	if (needolin) && phantom == false && not possibleBossList.has("Phantom"):
		possibleBossList.append("Phantom")
	if (fourthChorus && savageBeastflyOne && actTwo) && savageBeastflyTwo == false && not possibleBossList.has("Savage Beastfly 2") && actOneLimiter == false:
		possibleBossList.append("Savage Beastfly 2")
	if (actTwo) && cogworkDancers == false && not possibleBossList.has("Cogwork Dancers") && actOneLimiter == false:
		possibleBossList.append("Cogwork Dancers")
	if (cogworkDancers) && trobbio == false && not possibleBossList.has("Trobbio") && actOneLimiter == false:
		possibleBossList.append("Trobbio")
	if (cogworkDancers && clawline) && garmondAndZaza == false && not possibleBossList.has("Garmond & Zaza") && actOneLimiter == false:
		possibleBossList.append("Garmond & Zaza")
	if (clawline) && forebrothers == false && not possibleBossList.has("Forebrothers Signis & Gron") && actOneLimiter == false:
		possibleBossList.append("Forebrothers Signis & Gron")
	if (clawline) && unravelled == false && not possibleBossList.has("The Unravelled") && actOneLimiter == false:
		possibleBossList.append("The Unravelled")
	if (faydownCloak) && lugoli == false && not possibleBossList.has("Disgraced Chef Lugoli") && actOneLimiter == false:
		possibleBossList.append("Disgraced Chef Lugoli")
	if (faydownCloak) && fatherFlame == false && not possibleBossList.has("Father of the Flame") && actOneLimiter == false:
		possibleBossList.append("Father of the Flame")
	if (faydownCloak) && voltvyrm == false && not possibleBossList.has("Voltvyrm") && actOneLimiter == false:
		possibleBossList.append("Voltvyrm")
	if (clawline) && ragingConchfly == false && not possibleBossList.has("Raging Conchfly") && actOneLimiter == false:
		possibleBossList.append("Raging Conchfly")
	if (faydownCloak) && secondSentinel == false && not possibleBossList.has("Second Sentinel") && actOneLimiter == false:
		possibleBossList.append("Second Sentinel")
	if (faydownCloak) && groal == false && not possibleBossList.has("Groal the Great") && actOneLimiter == false:
		possibleBossList.append("Groal the Great")
	if (greatConchflies && faydownCloak) && shakra == false && not possibleBossList.has("Shakra") && actOneLimiter == false:
		possibleBossList.append("Shakra")
	if (actTwo) && broodmother == false && not possibleBossList.has("Broodmother") && actOneLimiter == false:
		possibleBossList.append("Broodmother")
	if (faydownCloak) && firstSinner == false && not possibleBossList.has("First Sinner") && actOneLimiter == false:
		possibleBossList.append("First Sinner")
	if (cogworkDancers && trobbio && clawline) && laceTwo == false && not possibleBossList.has("Lace 2") && actOneLimiter == false:
		possibleBossList.append("Lace 2")
	if (laceTwo && (doubleGMS == false && silkAndSoul || doubleGMS)) && grandMotherSilk == false && not possibleBossList.has("Grand Mother Silk") && actOneLimiter == false:
		possibleBossList.append("Grand Mother Silk")
	if (actThree) && bellEater == false && not possibleBossList.has("Bell Eater") && actTwoLimiter == false:
		possibleBossList.append("Bell Eater")
	if (actThree) && lostGarmond == false && not possibleBossList.has("Lost Garmond") && actTwoLimiter == false:
		possibleBossList.append("Lost Garmond")
	if (actThree) && plasmifiedZango == false && not possibleBossList.has("Plasmified Zango") && actTwoLimiter == false:
		possibleBossList.append("Plasmified Zango")
	if (actThree) && pinstress == false && not possibleBossList.has("Pinstress") && actTwoLimiter == false:
		possibleBossList.append("Pinstress")
	if (silkSoar) && tormentedTrobbio == false && not possibleBossList.has("Tormented Trobbio") && actTwoLimiter == false:
		possibleBossList.append("Tormented Trobbio")
	if (silkSoar) && watcherEdge == false && not possibleBossList.has("Watcher at the Edge") && actTwoLimiter == false:
		possibleBossList.append("Watcher at the Edge")
	if (actThree) && crawfather == false && not possibleBossList.has("Crawfather") && actTwoLimiter == false:
		possibleBossList.append("Crawfather")
	if (elegyDeep) && khann == false && not possibleBossList.has("Crust King Khann") && actTwoLimiter == false:
		possibleBossList.append("Crust King Khann")
	if (elegyDeep) && karmelita == false && not possibleBossList.has("Skarrsinger Karmelita") && actTwoLimiter == false:
		possibleBossList.append("Skarrsinger Karmelita")
	if (silkSoar) && gurr == false && not possibleBossList.has("Gurr the Outcast") && actTwoLimiter == false:
		possibleBossList.append("Gurr the Outcast")
	if (silkSoar) && seth == false && not possibleBossList.has("Shrine Guardian Seth") && actTwoLimiter == false:
		possibleBossList.append("Shrine Guardian Seth")
	if (elegyDeep) && nyleth == false && not possibleBossList.has("Nyleth") && actTwoLimiter == false:
		possibleBossList.append("Nyleth")
	if (elegyDeep) && palestag == false && not possibleBossList.has("Palestag") && actTwoLimiter == false:
		possibleBossList.append("Palestag")
	if (palestag && elegyDeep) && cloverDancers == false && not possibleBossList.has("Clover Dancers") && actTwoLimiter == false:
		possibleBossList.append("Clover Dancers")
	if (everbloom) && lostLace == false && not possibleBossList.has("Lost Lace") && actTwoLimiter == false:
		possibleBossList.append("Lost Lace")

# Sets other reqs to true based on conditions
func checkOtherReqs():
	if khann:
		khannCounter = 1
	else:
		khannCounter = 0
	if karmelita:
		karmelitaCounter = 1
	else:
		karmelitaCounter = 0
	if nyleth:
		nylethCounter = 1
	else:
		nylethCounter = 0
	if cloverDancers:
		cloverCounter = 1
	else:
		cloverCounter = 0
	everbloomCounter = khannCounter + karmelitaCounter + nylethCounter + cloverCounter
	if bellBeast:
		swiftStep = true
	else:
		swiftStep = false
	if fourthChorus:
		driftersCloak = true
	else:
		driftersCloak = false
	if sisterSplinter:
		clingGrip = true
	else:
		clingGrip = false
	if widow:
		needolin = true
	else:
		needolin = false
	if actTwo && driftersCloak:
		clawline = true
	else:
		clawline = false
	if clawline:
		faydownCloak = true
	else:
		faydownCloak = false
	if actThree && forebrothers:
		silkSoar = true
	else:
		silkSoar = false
	if silkSoar:
		elegyDeep = true
	else:
		elegyDeep = false
	if everbloomCounter >= 3:
		everbloom = true
	else:
		everbloom = false
	if (blackThreads == false || savageBeastflyOne && moorwing && skullTyrant && mossMotherTwo && savageBeastflyTwo && lugoli):
		blackThreadsBool = true
	else:
		blackThreadsBool = false
	if (groal && laceTwo) && (garmondAndZaza && shakra) && blackThreadsBool:
		silkAndSoul = true
	else:
		silkAndSoul = false
	if laceOne && (lastJudge || phantom):
		actTwo = true
	else:
		actTwo = false
	if silkAndSoul && grandMotherSilk:
		actThree = true
	else:
		actThree = false

func getBossesDefeated():
	# Checks if the boss has already been added to randomBossList
	if randomBossList.has("Moss Mother 1"):
		mossMotherOne = true
	else:
		mossMotherOne = false
	if randomBossList.has("Bell Beast"):
		bellBeast = true
	else:
		bellBeast = false
	if randomBossList.has("Lace 1"):
		laceOne = true
	else:
		laceOne = false
	if randomBossList.has("Fourth Chorus"):
		fourthChorus = true
	else:
		fourthChorus = false
	if randomBossList.has("Savage Beastfly 1"):
		savageBeastflyOne = true
	else:
		savageBeastflyOne = false
	if randomBossList.has("Moorwing"):
		moorwing = true
	else:
		moorwing = false
	if randomBossList.has("Sister Splinter"):
		sisterSplinter = true
	else:
		sisterSplinter = false
	if randomBossList.has("Skull Tyrant"):
		skullTyrant = true
	else:
		skullTyrant = false
	if randomBossList.has("Widow"):
		widow = true
	else:
		widow = false
	if randomBossList.has("Moss Mother 2"):
		mossMotherTwo = true
	else:
		mossMotherTwo = false
	if randomBossList.has("Great Conchflies"):
		greatConchflies = true
	else:
		greatConchflies = false
	if randomBossList.has("Last Judge"):
		lastJudge = true
	else:
		lastJudge = false
	if randomBossList.has("Phantom"):
		phantom = true
	else:
		phantom = false
	if randomBossList.has("Savage Beastfly 2"):
		savageBeastflyTwo = true
	else:
		savageBeastflyTwo = false
	if randomBossList.has("Cogwork Dancers"):
		cogworkDancers = true
	else:
		cogworkDancers = false
	if randomBossList.has("Trobbio"):
		trobbio = true
	else:
		trobbio = false
	if randomBossList.has("Garmond & Zaza"):
		garmondAndZaza = true
	else:
		garmondAndZaza = false
	if randomBossList.has("Forebrothers Signis & Gron"):
		forebrothers = true
	else:
		forebrothers = false
	if randomBossList.has("The Unravelled"):
		unravelled = true
	else:
		unravelled = false
	if randomBossList.has("Disgraced Chef Lugoli"):
		lugoli = true
	else:
		lugoli = false
	if randomBossList.has("Father of the Flame"):
		fatherFlame = true
	else:
		fatherFlame = false
	if randomBossList.has("Voltvyrm"):
		voltvyrm = true
	else:
		voltvyrm = false
	if randomBossList.has("Raging Conchfly"):
		ragingConchfly = true
	else:
		ragingConchfly = false
	if randomBossList.has("Second Sentinel"):
		secondSentinel = true
	else:
		secondSentinel = false
	if randomBossList.has("Groal the Great"):
		groal = true
	else:
		groal = false
	if randomBossList.has("Shakra"):
		shakra = true
	else:
		shakra = false
	if randomBossList.has("Broodmother"):
		broodmother = true
	else:
		broodmother = false
	if randomBossList.has("First Sinner"):
		firstSinner = true
	else:
		firstSinner = false
	if randomBossList.has("Lace 2"):
		laceTwo = true
	else:
		laceTwo = false
	if randomBossList.has("Grand Mother Silk"):
		grandMotherSilk = true
	else:
		grandMotherSilk = false
	if randomBossList.has("Bell Eater"):
		bellEater = true
	else:
		bellEater = false
	if randomBossList.has("Lost Garmond"):
		lostGarmond = true
	else:
		lostGarmond = false
	if randomBossList.has("Plasmified Zango"):
		plasmifiedZango = true
	else:
		plasmifiedZango = false
	if randomBossList.has("Pinstress"):
		pinstress = true
	else:
		pinstress = false
	if randomBossList.has("Tormented Trobbio"):
		tormentedTrobbio = true
	else:
		tormentedTrobbio = false
	if randomBossList.has("Watcher at the Edge"):
		watcherEdge = true
	else:
		watcherEdge = false
	if randomBossList.has("Crawfather"):
		crawfather = true
	else:
		crawfather = false
	if randomBossList.has("Crust King Khann"):
		khann = true
	else:
		khann = false
	if randomBossList.has("Skarrsinger Karmelita"):
		karmelita = true
	else:
		karmelita = false
	if randomBossList.has("Gurr the Outcast"):
		gurr = true
	else:
		gurr = false
	if randomBossList.has("Shrine Guardian Seth"):
		seth = true
	else:
		seth = false
	if randomBossList.has("Nyleth"):
		nyleth = true
	else:
		nyleth = false
	if randomBossList.has("Palestag"):
		palestag = true
	else:
		palestag = false
	if randomBossList.has("Clover Dancers"):
		cloverDancers = true
	else:
		cloverDancers = false
	if randomBossList.has("Lost Lace"):
		lostLace = true
	else:
		lostLace = false
