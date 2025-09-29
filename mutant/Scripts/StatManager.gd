extends Node

@export var _headLimb : BaseLimb
var _summedWeight : float = 0
var _summedSpeed : float = 0
var _summedHealth : float = 0

func __onReady():
	#for child in get_children():
	#	Limbs.append(child.Base_Limb)
	_summedWeight = __calculateWeight(_headLimb)
	_summedSpeed = __calculateSpeed(_headLimb)
	_summedHealth = __calculateHealth(_headLimb)
	print("Stats | Weight: " + str(_summedWeight) + " | Speed: " + str(_summedSpeed) + " | Health: " + str(_summedHealth))
	_headLimb.__addChildLimb(get_child(1))
	_headLimb.__executeBranchingFunctions(0)
	pass
func __calculateWeight(limb : BaseLimb) -> float:
	var sumWeight = 0.0
	for subLimb in limb._childLimbs:
		sumWeight += __calculateWeight(subLimb)
	return sumWeight + limb.weight
func __calculateSpeed(limb : BaseLimb) -> float:
	var sumSpeed = 0.0
	for subLimb in limb._childLimbs:
		sumSpeed += __calculateSpeed(subLimb)
	return sumSpeed + limb.speed
func __calculateHealth(limb : BaseLimb) -> float:
	var sumHealth = 0.0
	for subLimb in limb._childLimbs:
		sumHealth += __calculateHealth(subLimb)
	return sumHealth + 3.0
