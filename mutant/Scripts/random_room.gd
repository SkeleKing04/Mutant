extends Node3D

@export var AssetPoints : Array[Node]


func _on_ready() -> void:
	var index = randi_range(0, AssetPoints.size() - 1)
	print(AssetPoints[index].name)
