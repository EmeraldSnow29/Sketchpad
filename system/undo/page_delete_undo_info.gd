class_name PageDeleteUndoInfo
extends UndoInfo

#stores info on deleted pages
var index: int
var page: Page

func _init(_page: Page, _index: int):
	page = _page
	index = _index

func restore(project: Project) -> void:
	#restore the deleted page
	project.frames.insert(index, page)
	project.set_frame(index)

	#reconnect signal
	page.page_update.connect(project._on_page_update)

	page.page_update.emit()
	#project will emit frames_update
