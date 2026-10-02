class_name PageCreateUndoInfo
extends UndoInfo

#stores info on page creation.
var index: int

func _init(_index: int):
	index = _index

func restore(project: Project) -> void:
	#simply delete the page
	project.delete_frame_no_undo_signal(index)
