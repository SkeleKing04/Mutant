extends Node

class_name Limb_Manager

var parent_socket = null
var child_sockets = []

#adds a new attachment to this
func add_child_socket(new_child : Limb_Manager):
	child_sockets.append(new_child)
	new_child.attach_to_socket(self)
	return

#removes an existing attachment to this
func remove_child_socket(target_child : Limb_Manager):
	#attempts to find the target in the array - return -1 if it doesn't
	var index = child_sockets.find(target_child)
	#then removes the target if found
	if index >= 0:
		child_sockets[index].remove_self_from_socket()
		child_sockets.remove_at(index)
	return

#adds self to target
func attach_to_socket(target_limb : Limb_Manager):
	parent_socket = target_limb
	return

#removes self from parent
func remove_self_from_socket():
	parent_socket = null
	return;

func run_operations(data):
	#do things
	for limb in child_sockets:
		limb.run_operations(data)
	return
