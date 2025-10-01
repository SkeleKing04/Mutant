extends Node

@export var _headLimb : BaseLimb
var _summedWeight : float = 0
var _summedSpeed : float = 0
var _summedHealth : float = 0
var _limbCount : int = 0

func __onReady():
	__initialiseBody()
	_headLimb.__executeBranchingFunctions(0)
	pass
	
func __initialiseBody():
	_limbCount = __calculateLimbCount(_headLimb)
	_summedWeight = __calculateWeight(_headLimb)
	_summedSpeed = __calculateSpeed(_headLimb) / _summedWeight
	_summedHealth = __calculateHealth(_headLimb)
	print("Stats | Limb Count: " + str(_limbCount) + " | Weight: " + str(_summedWeight) + " | Speed: " + str(_summedSpeed) + " | Health: " + str(_summedHealth))

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
	
func __calculateLimbCount(limb : BaseLimb) -> int:
	var sumLimbs = 0
	for subLimb in limb._childLimbs:
		sumLimbs += __calculateLimbCount(subLimb)
	return sumLimbs + 1


func __onButtonPressed() -> void:
	var target = _headLimb
	if _headLimb._childLimbs.size() > 0 and randi_range(0, 10) > 2:
		target = _headLimb._childLimbs[randi_range(0, _headLimb._childLimbs.size() - 1)]
		
	target.__addChildLimb(BaseLimb.new(10, 3, randi_range(0, 4)))
	__initialiseBody()
	_headLimb.__executeBranchingFunctions(0)
	pass # Replace with function body.
