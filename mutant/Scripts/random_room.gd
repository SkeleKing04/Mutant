extends Node3D

@export var AssetPoints : Array[Node3D]
@export var AssetScenes : Array[PackedScene]

func _on_ready() -> void:
	var hits = 0
	for point in AssetPoints:
		if(randi_range(0, 10) > 2):
			hits += 1
			var newInst = AssetScenes[randi_range(0, AssetScenes.size() - 1)].instantiate()
			add_child(newInst)
			#for child in get_children():
			#	if child is Node3D and newInst:
			newInst.position = point.position
			newInst.rotation = Vector3(0, randi_range(0, 614) / 100.0, 0)
			print(newInst.name + " was placed at " + point.name)
	print("in total, " + str(hits) + " objects were placed")
