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
	#restore the page by overwriting it with this replacement
	project.frames[index] = page
	project.set_frame(index)

	#fix for undoing adding layers
	if project.current_layer >= page.layers.size():
		project.set_layer(page.layers.size() - 1)

	#reconnect signal
	page.page_update.connect(project._on_page_update)

	page.page_update.emit()
	#project will emit frames_update
