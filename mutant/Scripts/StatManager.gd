extends Node

var _summedWeight : float = 0
var _summedSpeed : float = 0
var _summedHealth : float = 0
var _limbCount : Array[int] = [0, 0, 0, 0, 0]
#the first is for arms, then legs, then any extras
@export var _sockets : Dictionary = {"Arms" : {}, "Legs" : {}, "Other" : {}}

func __limbSum() -> int:
	var sum = 0
	for value in _limbCount:
		sum += value
	return sum

func __onReady():
	_sockets["Arms"]
	pass
	
func __executeLimbTrees():
	for key in _sockets:
		for socket in _sockets[key]:
			get_node_and_resource(socket)[0].__executeBranchingFunctions(0)

func __doLimbMaths():
	#reset limb counts
	for index in _limbCount.size():
		_limbCount[index] = 0
	
	#count all the limbs
	for key in _sockets:
		for socket in _sockets[key]:
			__calculateLimbCount(get_node_and_resource(socket)[0])
	
	#calculate the stats
	_summedWeight = 0
	_summedHealth = 0
	_summedSpeed = 0
	for key in _sockets:
		for socket in _sockets[key]:
			var sock = get_node_and_resource(socket)[0]
			_summedWeight += __calculateWeight(sock)
			_summedSpeed += __calculateSpeed(sock)
			_summedHealth += __calculateHealth(sock)
	_summedSpeed /= _summedWeight
	#print them out
	print("Stats | Limb Count: " + str(_limbCount) + " = " + str(__limbSum()) + " | Weight: " + str(_summedWeight) + " | Speed: " + str(_summedSpeed) + " | Health: " + str(_summedHealth))

func __calculateWeight(limb : BaseLimb) -> float:
	var sumWeight = 0.0
	for subLimb in limb._childLimbs:
		sumWeight += __calculateWeight(subLimb)
	return sumWeight + limb._weight
	
func __calculateSpeed(limb : BaseLimb) -> float:
	var sumSpeed = 0.0
	match limb._type:
		1:
			sumSpeed = limb._speed
		_:
			sumSpeed = limb._speed * 0.5

	for subLimb in limb._childLimbs:
		sumSpeed += __calculateSpeed(subLimb)
	return sumSpeed
	
func __calculateHealth(limb : BaseLimb) -> float:
	var sumHealth = 0.0
	for subLimb in limb._childLimbs:
		sumHealth += __calculateHealth(subLimb)
	return sumHealth + limb._weight * 0.5
	
func __calculateLimbCount(limb : BaseLimb):
	for subLimb in limb._childLimbs:
		__calculateLimbCount(subLimb)
	_limbCount[limb._type] += 1

#debug function - does whatever you need it to - REMOVE BEFORE ANY RELEASE!!!
func __onButtonPressed(key):
	#adding a limb to a random socket
	#sum the socket weights
	var sumWeights = 0
	for socket in _sockets[key]:
		sumWeights += _sockets[key][socket]
	var roundedWeights = _sockets[key].values()
	for weight in roundedWeights:
		weight /= sumWeights
		
	var rnd = randi_range(0, 100) / 100.0
	var totalWeight = 0
	for i in roundedWeights.size():
		totalWeight += roundedWeights[i]
		if rnd <= totalWeight:
			#apply the limb here
			#print(str(_sockets[key].keys()[i]))
			get_node_and_resource(_sockets[key].keys()[i])[0].__addChildLimb(BaseLimb.new())
			__doLimbMaths()
			__executeLimbTrees()
			pass
		
	pass
