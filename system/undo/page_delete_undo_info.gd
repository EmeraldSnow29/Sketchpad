class_name PageDeleteUndoInfo
extends UndoInfo

#stores info on deleted pages
var index: int
var page: Page

func _init(_page: Page, _index: int):
	page = _page
	index = _index

func restore(project: Project) -> void:
	#page should already be connected,
	#so signal connection shouldn't have to be restored.
	#restore the deleted page
	project.frames.insert(index, page)
	project.set_frame(index)
	
	page.page_update.emit()
	project.frames_update.emit()
