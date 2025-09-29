extends Node2D

class_name BaseLimb
@export var weight : float
@export var speed : float

var _parentLimb = null
@export var _childLimbs : Array[BaseLimb]

func __limbFunction():
	print("Hello World! Its me, " + name)

# the parent should do all the managing all the children

#adds a new attachment to this
func __addChildLimb(newChild : BaseLimb):
	# attaches the child to this
	_childLimbs.append(newChild)
	# applies the changes to the child
	newChild._parentLimb = self
	newChild.reparent(self)
	return

#removes an existing attachment to this
func __removeChildLimb(targetChild : BaseLimb):
	#attempts to find the target in the array - return -1 if it doesn't
	var index = _childLimbs.find(targetChild)
	#then removes the target if found
	if index >= 0:
		_childLimbs[index]._parentLimb = null
		_childLimbs[index].reparent(null)
		_childLimbs.remove_at(index)
	return

func __executeBranchingFunctions(data):
	#do things
	__limbFunction()
	for limb in _childLimbs:
		# run the functions in the base limbs
		limb.__executeBranchingFunctions(data)
	return
