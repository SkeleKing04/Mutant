extends Node

class_name LimbTable

static func __generateNewLimb(data):
	var typeWeight : Array[float] = [0,0,0,0,0]
	for index in data._limbCount.size():
		typeWeight[index] = data._limbCount[index]
	var type : BaseLimb.LimbType
	var sum : float = data.__limbSum()
	for index in typeWeight.size():
		typeWeight[index] = typeWeight[index] / sum
	
	var rnd = randi_range(0, 100)
	var value = 0
	for index in typeWeight.size():
		value += typeWeight[index] * 100
		if value >= rnd:
			type = index as BaseLimb.LimbType
	
	# or this could pull from an existing limb table, where only the type is needed
	var NewLimb : BaseLimb = BaseLimb.new(0,0,type)
	return NewLimb
