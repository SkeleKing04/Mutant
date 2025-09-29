extends Node

class_name Limb_Manager

var parent_socket = null
var child_sockets = Array[Limb_Manager]

# the parent should do all the managing all the children

#adds a new attachment to this
func add_child_socket(new_child : Limb_Manager):
	# attaches the child to this
	child_sockets.append(new_child)
	# applies the changes to the child
	new_child.parent_socket = self
	return

#removes an existing attachment to this
func remove_child_socket(target_child : Limb_Manager):
	#attempts to find the target in the array - return -1 if it doesn't
	var index = child_sockets.find(target_child)
	#then removes the target if found
	if index >= 0:
		child_sockets[index].parent_socket = null
		child_sockets.remove_at(index)
	return

func run_operations(data):
	#do things
	for limb in child_sockets:
		limb.run_operations(data)
	return
