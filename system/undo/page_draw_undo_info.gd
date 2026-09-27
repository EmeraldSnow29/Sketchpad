class_name PageDrawUndoInfo
extends UndoInfo

#stores info on page drawing and layer changes.
var index: int
var page: Page

func _init(_page: Page, _index: int):
	#this could be made more optimal but im lazy
	page = _page.duplicate_deep() #to preserve version
	index = _index

func restore(project: Project) -> void:
	#page should already be connected,
	#so signal connection shouldn't have to be restored.
	#restore the page by overwriting it with this replacement
	project.frames[index] = page
	project.set_frame(index)
	
	#fix for undoing adding layers
	if project.current_layer >= page.layers.size():
		project.set_layer(page.layers.size() - 1)
		
	page.page_update.emit()
	project.frames_update.emit()
